class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_subscription, only: [:update, :cancel]
  
  def new
    @subscription = Subscription.new
  end
  
  def update
    @subscription.update_attributes! params[:subscription]

    respond_to do |format|
      format.js   { render :json => @subscription.as_json(include: :address), :status => 200 }
      format.html {
        flash[:notice] = 'Account successfully updated'
        redirect_to account_path
      }
    end
  end

  def cancel
    @subscription.cancel
    flash[:alert] = 'Your subscription was canceled.'
    redirect_to account_path
  end

  def create
    Subscription.transaction do
      # get the plan selected
      @plan = Plan.find_by_code params[:plan][:id]
    
      # get the shipping address, set default
      @address = Address.new params[:address]
      @address.is_default = true
    
      # save the shipping address
      current_user.addresses << @address
    
      # save the credit card to braintree
      result = Braintree::CreditCard.create(
        :customer_id => current_user.customer_id, 
        :number => params[:credit_card][:number], 
        :expiration_date => "#{params[:credit_card]['expires_at(2i)']}/#{params[:credit_card]['expires_at(1i)']}", 
        :cvv => params[:credit_card][:cvv],
        :options => { :make_default => true }
      )
    
      # save user credit card
      if result.success?
        @credit_card = CreditCard.new(
          :token => result.credit_card.token, 
          :card_type => result.credit_card.card_type, 
          :last4 => result.credit_card.last_4, 
          :expiration_month => result.credit_card.expiration_month, 
          :expiration_year => result.credit_card.expiration_year,
          :is_default => result.credit_card.default?
        ) 
        current_user.credit_cards << @credit_card
        flash[:notice] = 'Credit card saved'
      else
        throw Exception.new result.message
      end
      
      # create an order
      @order = Order.create(user: current_user, address: @address)
      
      # create order line items
      @order.line_items << LineItem.new(sku: @plan.sku, sku_qty: 1, unit_price: @plan.sku.unit_price)
      
      # create invoice for order
      @invoice = Invoice.create!(user: current_user, order: @order, subtotal: @plan.price, total: @plan.price, due_at: Time.now)
    
      # create a braintree subscription
      result = Braintree::Subscription.create(
        :payment_method_token => current_user.default_credit_card.token,
        :plan_id => @plan.code
      )
    
      # if payment successful
      if result.success?
        # save credit card transaction details
        txn = result.subscription.transactions[0]
        @invoice.credit_card_transactions <<  CreditCardTransaction.new(
          :subject => @order,
          :user => current_user,
          :credit_card => @credit_card,
          :transaction_type => txn.type,
          :transaction_id => txn.id,
          :amount => txn.amount,
          :status => txn.status,
          :avs_error_response_code => txn.avs_error_response_code,
          :avs_postal_code_response_code => txn.avs_postal_code_response_code,
          :avs_street_address_response_code => txn.avs_street_address_response_code,
          :cvv_response_code => txn.cvv_response_code,
          :gateway_rejection_reason => txn.gateway_rejection_reason,
          :processor_authorization_code => txn.processor_authorization_code,
          :processor_response_code => txn.processor_response_code,
          :processor_response_text => txn.processor_response_text
        )
        
        # mark invoice as paid
        @invoice.mark_paid
        
        # save subscription details
        @subscription = Subscription.create(
          user: current_user,
          plan: @plan,
          address: @address,
          credit_card: @credit_card,
          token: result.subscription.id,
          # status: result.subscription.status,
          billing_day_of_month: result.subscription.billing_day_of_month,
          billing_period_start_date: result.subscription.billing_period_start_date,
          billing_period_end_date: result.subscription.billing_period_end_date,
          failure_count: result.subscription.failure_count,
          first_billing_date: result.subscription.first_billing_date,
          next_billing_date: result.subscription.next_billing_date,
          next_billing_period_amount: result.subscription.next_billing_period_amount,
          paid_through_date: result.subscription.paid_through_date
        )
        
        # update order subscription
        @order.update_attribute(:subscription, @subscription)
        
        # schedule shipments
        (0..(@plan.billing_cycle-1)).to_a.each do |i|
          @order.shipments << Shipment.new(user: current_user, subscription: @subscription, address: @order.address, scheduled_at: Date.today.advance(months: i))
        end
        
      else
        
      end
    end
    
  end

  protected
    def load_subscription
      @subscription = Subscription.find params[:id]
    end
end
