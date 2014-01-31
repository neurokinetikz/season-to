class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :plan
  
  attr_accessible :billing_day_of_month, :first_billing_date, :billing_period_start_date, :billing_period_end_date, :paid_through_date
  attr_accessible :next_billing_date, :next_billing_period_amount_cents, :failure_count
  
  monetize :next_billing_period_amount_cents
end
