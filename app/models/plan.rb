class Plan < ActiveRecord::Base
  attr_accessible :code, :name, :description
  attr_accessible :price, :billing_cycle
  
  monetize :price_cents
  
  has_many :subscriptions
end
