class CreditCard < ActiveRecord::Base
  acts_as_paranoid
  
  attr_accessor :number, :cvv, :cardholder_name, :billing_address
  
  attr_accessible :number, :cvv, :cardholder_name, :billing_address
  attr_accessible :token, :card_type, :last4, :expires_at, :expiration_month, :expiration_year, :is_default
  
  belongs_to :user

  has_many :credit_card_transactions
  has_many :subscriptions

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
        # update default card on braintree
        result = Braintree::CreditCard.update(
          self.token,
          :options => { :make_default => true }
        )
      
        throw Exception.new "Could not set default credit card" unless result.success?
        
        # update linked subscriptions
        self.user.subscriptions.each do |sub|
          result =  Braintree::Subscription.update(sub.token, payment_method_token: self.token)
          throw Exception.new "Could not update subscription credit card" unless result.success?
          sub.update_attribute(:credit_card, self)
        end

        

        self.user.credit_cards.where("id <> ?", self.id).update_all(:is_default => false)
      end
    end
  end
end