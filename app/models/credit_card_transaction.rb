class CreditCardTransaction < ActiveRecord::Base
  attr_accessible :status, :transaction_type, :transaction_id, :user, :credit_card, :credit_card_description
  attr_accessible :avs_error_response_code, :avs_postal_code_response_code, :avs_street_address_response_code, :cvv_response_code
  attr_accessible :gateway_rejection_reason, :processor_authorization_code, :processor_response_code, :processor_response_text

  attr_accessible :amount
  monetize :amount_cents

  belongs_to :user
  belongs_to :credit_card
  belongs_to :source, :polymorphic => true
  belongs_to :subject, :polymorphic => true
end