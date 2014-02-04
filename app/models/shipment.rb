class Shipment < ActiveRecord::Base
  belongs_to :user
  belongs_to :subscription
  belongs_to :order
  belongs_to :address
  
  attr_accessible :user, :subscription, :order, :address, :scheduled_at
  
  state_machine :state, :initial => :scheduled do
  end
end
