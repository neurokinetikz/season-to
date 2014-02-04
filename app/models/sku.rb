class Sku < ActiveRecord::Base
  belongs_to :product
  
  attr_accessible :code, :name, :description, :unit_price
  
  monetize :unit_price_cents
end
