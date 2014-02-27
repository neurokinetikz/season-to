class Product < ActiveRecord::Base
  belongs_to :vendor

  has_many :images, as: :attachable
  has_many :skus

  attr_accessible :vendor_id, :name, :description, :images_attributes, :skus_attributes

  accepts_nested_attributes_for :images, :skus
end
