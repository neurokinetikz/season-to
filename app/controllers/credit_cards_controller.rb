class CreditCardsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_credit_card, :only => [:update, :charge, :destroy]
  before_filter :verify_owner, :only => [:update, :charge, :destroy]
  
  def create
    @result = Braintree::CreditCard.create(
      :customer_id => current_user.customer_id, 
      :number => params[:credit_card][:number], 
      :expiration_date => "#{params[:credit_card]['expires_at(2i)']}/#{params[:credit_card]['expires_at(1i)']}", 
      :cvv => params[:credit_card][:cvv],
      :options => { :make_default => (params[:credit_card][:is_default] == '1') }
    )
    
    if @result.success?
      @credit_card = CreditCard.new(
        :token => @result.credit_card.token, 
        :card_type => @result.credit_card.card_type, 
        :last4 => @result.credit_card.last_4, 
        :expiration_month => @result.credit_card.expiration_month, 
        :expiration_year => @result.credit_card.expiration_year,
        :is_default => @result.credit_card.default?
      ) 
      current_user.credit_cards << @credit_card
      flash[:notice] = 'Credit card saved'
    else
      flash[:alert] = @result.message
    end
    
    
    
    respond_to do |format|
      format.js   {}
      format.html {
        v = {}
        v[:notice] = 'Credit card saved' if @result.success?
        v[:alert] = @result.message unless @result.success?
        redirect_to account_path, v
      } 
    end
  end
  
  def update
    @credit_card.update_attributes(params[:credit_card])
    render :json => @credit_card, :status => 200
  end
  
  def charge
    @result = Braintree::Transaction.sale(:payment_method_token => @credit_card.token, :amount => params[:amount], :options => {:submit_for_settlement => true})
    @credit_card_transaction = CreditCardTransaction.create(
      :user => current_user,
      :credit_card => @credit_card,
      :credit_card_description => @credit_card.to_s,
      :transaction_type => @result.transaction.type,
      :token => @result.transaction.id,
      :amount => @result.transaction.amount,
      :status => @result.transaction.status,
      :avs_error_response_code => @result.transaction.avs_error_response_code,
      :avs_postal_code_response_code => @result.transaction.avs_postal_code_response_code,
      :avs_street_address_response_code => @result.transaction.avs_street_address_response_code,
      :cvv_response_code => @result.transaction.cvv_response_code,
      :gateway_rejection_reason => @result.transaction.gateway_rejection_reason,
      :processor_authorization_code => @result.transaction.processor_authorization_code,
      :processor_response_code => @result.transaction.processor_response_code,
      :processor_response_text => @result.transaction.processor_response_text
    )
    
    if @result.success? 
      flash[:notice] = "Your transaction was successful: $#{@credit_card_transaction.amount} was charged to #{@credit_card.to_s}"
    else
      flash[:alert] = "Your transaction was not successful: #{@result.message}"
    end
    
    respond_to do |format|
      format.js   {}
      format.html {redirect_to account_path} 
    end
    
  end
  
  def destroy
    if @credit_card.is_default
      new_default_card = @credit_card.user.credit_cards.where("id <> ?", @credit_card.id).order("id desc").first
      new_default_card.update_attribute(:is_default, true) unless new_default_card.nil?
    end
    @credit_card.destroy
    
    respond_to do |format|
      format.js   {}
      format.html {redirect_to account_path, :notice => 'Credit card removed'} 
    end
  end
  
  protected
  def load_credit_card
    @credit_card = CreditCard.find(params[:id])
    @credit_card_id = @credit_card.id
  end
  
  def verify_owner
    throw Exception.new unless current_user == @credit_card.user
  end
end
