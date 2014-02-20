class Address < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :address1, :address2, :city, :state, :zip, :addressable_type, :addressable_id
  
  belongs_to :addressable, :polymorphic => true

  def to_s
   "#{address1}, #{city}, #{state} #{zip}"
  end
end
