class BraintreeController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def challenge
    render :text => Braintree::WebhookNotification.verify(params[:bt_challenge])
  end

  def webhook
  	webhook_notification = Braintree::WebhookNotification.parse(params[:bt_signature], params[:bt_payload])
    puts "[Webhook Received #{webhook_notification.timestamp}] Kind: #{webhook_notification.kind} | Subscription: #{webhook_notification.subscription.id}"
    puts "#{webhook_notification.subscription}"
    puts "#{webhook_notification.subscription.transactions}"

    @subscription = Subscription.find_by_token webhook_notification.subscription.id

    case webhook_notification.kind
    when 'subscription_charged_successfully'
      handle_transactions(webhook_notification)
    when 'subscription_charged_unsuccessfully'
    when 'subscription_went_active'
    when 'subscription_went_past_due'
    when 'subscription_canceled'
    when 'subscription_expired'
    end
    
    render nothing: true, status: 200
  end

  protected
    def handle_transactions(webhook_notification)
      webhook_notification.subscription.transactions.each do |txn|
        # check if transaction exists
        cct = CreditCardTransaction.find_by_token(txn.id)

        # if not, create a new record
        if true #cct.nil?
          Subscription.transaction do
            # get the credit card
            @credit_card = CreditCard.find_by_token(txn.credit_card_details.token)
            # throw exception if not found
            throw Exception.new "Unable to find credit card #{txn.credit_card_details.token}" if @credit_card.nil?

            # create an order
            @order = Order.create(user: @subscription.user, address: @subscription.address, subscription: @subscription)
        
            # create order line items
            @order.line_items << LineItem.new(sku: @subscription.plan.sku, sku_qty: 1, unit_price: @subscription.plan.sku.unit_price)
        
            # create invoice for order
            @invoice = Invoice.create!(user: @subscription.user, order: @order, subtotal: @subscription.plan.price, total: @subscription.plan.price, due_at: Time.now)

            # save the credit card transaction for the invoice
            @invoice.credit_card_transactions << CreditCardTransaction.new(
              :subject => @order,
              :user => @subscription.user,
              :credit_card => @credit_card,
              :transaction_type => txn.type,
              :token => txn.id,
              :amount => txn.amount,
              :status => txn.status
            )

            # mark invoice as paid
            @invoice.mark_paid

            # update the subscription
            @subscription.update_attributes(
              billing_period_start_date: webhook_notification.subscription.billing_period_start_date,
              billing_period_end_date: webhook_notification.subscription.billing_period_end_date,
              next_billing_date: webhook_notification.subscription.next_billing_date,
              next_billing_period_amount: webhook_notification.subscription.next_billing_period_amount,
              paid_through_date: webhook_notification.subscription.paid_through_date
            )

            # schedule shipments
          end
        end
      end
    end
end