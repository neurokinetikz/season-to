class Sku < ActiveRecord::Base
  belongs_to :product

  has_many :images, as: :attachable
  
  attr_accessible :code, :name, :description, :unit_price, :upc, :vendor_sku, :vendor_code, :product_id, :images_attributes
  
  monetize :unit_price_cents, :allow_nil => true

  accepts_nested_attributes_for :images
      
end
