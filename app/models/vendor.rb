class Vendor < ActiveRecord::Base
	has_many :addresses, as: :addressable

  attr_accessible :name, :description, :url, :phone, :addresses_attributes

  accepts_nested_attributes_for :addresses
end
