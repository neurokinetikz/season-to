class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :subscription
  belongs_to :address
  
  attr_accessible :user, :subscription, :address
  
  has_many :line_items, as: :itemizable
  has_many :shipments
  
  state_machine :state, :initial => :scheduled do
    
  end
end
