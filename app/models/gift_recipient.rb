class GiftRecipient < ActiveRecord::Base
  @@mandrill = Mandrill::API.new 'wiogzUeHpLTaZz9vSORNxw'

  belongs_to :gift
  belongs_to :user

  attr_accessible :gift, :user, :first_name, :last_name, :email, :message, :redeemed_at

  before_create :create_code
  after_create :send_recipient_email

  def name
    if first_name.nil? && last_name.nil?
      "Anonymous User"
    else
      "#{first_name} #{last_name}"
    end
  end

  def create_code
    self.code = SecureRandom.uuid
  end

  def send_recipient_email
    @@mandrill.messages.send_template 'gift-email', nil, 
      {to: [name: self.name, email: self.email, type: 'to'], 
        global_merge_vars: [
          {name: 'FIRSTNAME', content: self.first_name}, 
          {name: 'USER_FIRSTNAME', content: self.user.first_name},
          {name: 'USER_LASTNAME', content: self.user.last_name},
          {name: 'MESSAGE', content: self.message},
          {name: 'CODE', content: self.code}
        ]
      }
  end
end
