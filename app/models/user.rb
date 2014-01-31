class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         #:token_authenticatable, #:confirmable,
         :lockable, :timeoutable, :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :terms, :image
  attr_accessible :first_name, :last_name
  
  has_one :default_credit_card,  -> {where is_default: true}, :class_name => 'CreditCard'
  has_many :credit_cards
  has_many :credit_card_transactions
  
  has_many :list_users
  has_many :lists
  
  has_many :omniauths
  
  has_attached_file :image, 
    :styles => {
      :large => ["340x340>", :png],
      :medium => ["240x240>", :png],
      :small => ["140x140>", :png],
      :xsmall => ["40x40>", :png],
      :thumb => ["64x64#", :png]
    }, 
    :default_url => "/images/:style/missing.png"
    
  after_create :create_braintree_customer
  
  def name
    if first_name.nil? && last_name.nil?
      "Anonymous User"
    else
      "#{first_name} #{last_name}"
    end
  end
  
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = nil
    oauth = Omniauth.where(provider: auth.provider, uid: auth.uid).first
    unless oauth
      user = User.create(
        first_name: auth.extra.raw_info.first_name,
        last_name:  auth.extra.raw_info.last_name,
        email:      auth.info.email,
        password:   Devise.friendly_token[0,20]
      )
      user.omniauths << Omniauth.new({provider: auth.provider, uid: auth.uid, image: auth.info.image })
    else
      user = oauth.user
    end
    user
  end
  
  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = nil
    oauth = Omniauth.where(provider: auth.provider, uid: auth.uid).first
    unless oauth
      user = User.create(
        first_name: auth.extra.raw_info.first_name,
        last_name:  auth.extra.raw_info.last_name,
        email:      auth.info.email,
        password:   Devise.friendly_token[0,20]
      )
      user.omniauths << Omniauth.new({provider: auth.provider, uid: auth.uid, image: auth.info.image })
    else
      user = oauth.user
    end
    user
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
        user.first_name = data["first_name"] if user.first_name.blank?
        user.last_name = data["last_name"] if user.last_name.blank?
        user.omniauth_image = data["image"] if user.omniauth_image.blank?
      end
    end
  end
  
  
  #protected
  def create_braintree_customer
    result = Braintree::Customer.create(
      :first_name => self.first_name,
      :last_name => self.last_name,
      :email => self.email
    )
    if result.success?
      self.update_attribute(:customer_id, result.customer.id) 
    else
      throw Exception.new "Error creating Braintree customer"
    end
  end
end
