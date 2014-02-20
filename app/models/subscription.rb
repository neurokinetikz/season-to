class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :plan
  belongs_to :credit_card
  belongs_to :address
  
  attr_accessible :user, :plan, :token, :status, :credit_card, :address, :address_attributes, :address_id
  attr_accessible :billing_day_of_month, :first_billing_date, :billing_period_start_date, :billing_period_end_date, :paid_through_date
  attr_accessible :next_billing_date, :next_billing_period_amount, :failure_count

  has_many :orders
  has_many :shipments

  has_many :credit_card_transactions, through: :orders
  
  monetize :next_billing_period_amount_cents

  accepts_nested_attributes_for :address
  
  # after_create :schedule_shipments
  state_machine :state, :initial => :active do
    event :cancel do
      transition :active => :canceled
    end
    
    before_transition on: :cancel, do: :do_cancel
  end

  protected
  def schedule_shipments
    (0..(self.plan.billing_cycle-1)).to_a.each do |i|
      self.shipments << Shipment.new(user: self.user, scheduled_at: Date.today.advance(months: i))
    end
  end

  def do_cancel
    result = Braintree::Subscription.cancel(self.token)
    # throw Exception.new unless result.success?
  end
end
