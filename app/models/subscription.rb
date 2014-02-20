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
  
  monetize :next_billing_period_amount_cents

  accepts_nested_attributes_for :address
  
  # after_create :schedule_shipments
  
  protected
  def schedule_shipments
    (0..(self.plan.billing_cycle-1)).to_a.each do |i|
      self.shipments << Shipment.new(user: self.user, scheduled_at: Date.today.advance(months: i))
    end
  end
end
