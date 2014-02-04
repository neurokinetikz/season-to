class LineItem < ActiveRecord::Base
  belongs_to :itemizable, polymorphic: true
  belongs_to :sku
  
  attr_accessible :itemizable, :sku, :sku_qty, :unit_price
  
  monetize :unit_price_cents
end
