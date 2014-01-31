class Omniauth < ActiveRecord::Base
  attr_accessible :provider, :uid, :image, :name, :nickname
  
  belongs_to :user
end
