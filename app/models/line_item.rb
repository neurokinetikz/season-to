class LineItem < ActiveRecord::Base
  belongs_to :itemizable, polymorphic: true
  belongs_to :sku
  
  attr_accessible :itemizable, :sku, :sku_qty, :unit_price, :sku_id
  
  monetize :unit_price_cents, allow_nil: true
end
