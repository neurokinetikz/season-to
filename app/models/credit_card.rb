class CreditCard < ActiveRecord::Base
  acts_as_paranoid
  
  attr_accessor :number, :cvv, :cardholder_name, :billing_address
  
  attr_accessible :number, :cvv, :cardholder_name, :billing_address
  attr_accessible :token, :card_type, :last4, :expires_at, :expiration_month, :expiration_year, :is_default
  
  belongs_to :user

  has_many :credit_card_transactions

  after_save :handle_default_card

  before_destroy :delete_credit_card

  def masked_number
    "xxxx-xxxx-xxxx-#{last4}"
  end

  def to_s
    "#{card_type} ending in #{last4}"
  end
  
  def to_string
    "#{card_type} ending in #{last4}"
  end
  
  def expiration_date
    expires_at.strftime("%m/%Y")
  end

  protected
  def delete_credit_card
    begin
    Braintree::CreditCard.delete(self.token)
    rescue
      logger.debug "Credit card not deleted from braintree"
    end
  end
  
  def handle_default_card
    CreditCard.transaction do
      if ((self.is_default_changed? && self.is_default) || (self.new_record? && self.user.credit_cards.empty?))
        result = Braintree::CreditCard.update(
          self.token,
          :options => { :make_default => true }
        )
      
        throw Exception.new "Could not set default credit card on braintree" unless result.success?
        
        self.user.credit_cards.where("id <> ?", self.id).update_all(:is_default => false)
      end
    end
  end
end