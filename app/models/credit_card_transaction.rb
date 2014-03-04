class CreditCardTransaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :credit_card
  belongs_to :source, :polymorphic => true
  belongs_to :subject, :polymorphic => true
  
  attr_accessible :source, :subject, :transaction_type, :token, :user, :credit_card
  attr_accessible :avs_error_response_code, :avs_postal_code_response_code, :avs_street_address_response_code, :cvv_response_code
  attr_accessible :gateway_rejection_reason, :processor_authorization_code, :processor_response_code, :processor_response_text

  attr_accessible :amount
  monetize :amount_cents

  
end