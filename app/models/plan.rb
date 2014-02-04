class Plan < ActiveRecord::Base
  belongs_to :sku
  attr_accessible :sku, :code, :name, :description
  attr_accessible :price, :billing_cycle
  
  monetize :price_cents
  
  has_many :subscriptions
end
