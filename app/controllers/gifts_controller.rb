class GiftsController < ApplicationController
  before_filter :authenticate_user!

  def update
    @gift = Gift.find params[:id]
    @gift.update_attributes! params[:subscription]

    respond_to do |format|
      format.js   { render :json => @gift.as_json(include: :address), :status => 200 }
      format.html {
        flash[:notice] = 'Account successfully updated'
        redirect_to account_path
      }
    end
  end

  def create
    begin
      Gift.transaction do
        # get sku
        @plan = Plan.find_by_code params[:plan][:id]

        # get recipient
        @recipient = GiftRecipient.new params[:recipient]
        @recipient.user = current_user

        # handle credit card
        if params[:card_type] == 'existing-card'
          # get existing card, or
          @credit_card = current_user.credit_cards.find(params[:credit_card][:id])

        else
          # create new card on braintree
          result = Braintree::CreditCard.create(
            :customer_id => current_user.customer_id, 
            :number => params[:credit_card][:number], 
            :expiration_date => "#{params[:credit_card]['expires_at(2i)']}/#{params[:credit_card]['expires_at(1i)']}", 
            :cvv => params[:credit_card][:cvv]
          )
        
          # and save user card
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
          else
            flash[:alert] = result.message
            throw Exception.new 
          end
        end

        # create an order
        @order = Order.create(user: current_user)

        # create order line items
        @order.line_items << LineItem.new(sku: @plan.sku, sku_qty: 1, unit_price: @plan.sku.unit_price)
          
        # create invoice for order
        @order.mark_invoiced

        # process payment
        result = Braintree::Transaction.sale(:amount => @order.invoice.total, 
          :customer_id => current_user.customer_id, 
          :payment_method_token => @credit_card.token, 
          :options => { :submit_for_settlement => true }
        )

        # if payment successful
        if result.success?
          # save credit card transaction details
          txn = result.transaction
          @order.invoice.credit_card_transactions <<  CreditCardTransaction.new(
            :subject => @order,
            :user => current_user,
            :credit_card => @credit_card,
            :transaction_type => txn.type,
            :token => txn.id,
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
          @order.invoice.mark_paid

          # create gift
          @gift = Gift.create!(plan: @plan, gift_recipient: @recipient)

          # update order subscription
          @order.update_attribute(:subscription, @gift)


          redirect_to confirmation_gift_path(@gift) 
        else
          flash[:alert] = result.message
          throw Exception.new
        end
      end
    rescue
      render 'new' 
    end
  end

  def code
    # lookup code
    @recipient = GiftRecipient.find_by_code params[:code]

    # get gift
    @gift = @recipient.gift

    if @gift.active?
      flash[:notice] = 'Your gift has aleady been redeemed'
      redirect_to account_path
    elsif @gift.purchased?
      flash[:notice] = "Gift Redemption"
    end
  end

  def redeem
    Gift.transaction do
      # load gift
      @gift = Gift.find params[:id]

      # get order
      @order = @gift.orders.first

      # set gift user
      @gift.user = current_user

      # get the shipping address
      if params[:address_type] == 'existing-address'
        @address = current_user.addresses.find params[:subscription][:address_id]
      else
        @address = Address.new(params[:subscription][:address_attributes])
        current_user.addresses << @address
      end

      # set gift shipping address
      @gift.update_attribute(:address, @address)

      # redeem gift
      @gift.redeem
    end

    flash[:notice] = 'Gift Redeemed!'

    redirect_to account_path
  end

  def resend
    @gift = Gift.find params[:id]
    @gift.gift_recipient.send_recipient_email
    flash[:notice] = "Gift redemption email was sent to #{@gift.gift_recipient.first_name} #{@gift.gift_recipient.last_name} at #{@gift.gift_recipient.email}"
    redirect_to account_path
  end
end
