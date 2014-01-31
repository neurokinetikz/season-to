class Address < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :address1, :address2, :city, :state, :zip, :is_default
  
  belongs_to :addressable, :polymorphic => true
end
