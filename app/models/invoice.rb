class Invoice < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
  
  attr_accessible :user, :order, :subtotal, :tax, :shipping, :discount, :total, :due_at
  monetize :subtotal_cents
  monetize :tax_cents, :allow_nil => true
  monetize :shipping_cents, :allow_nil => true
  monetize :discount_cents, :allow_nil => true
  monetize :total_cents
  
  has_many :credit_card_transactions, as: :source
  
  state_machine :state, :initial => :invoiced do
    event :mark_paid do
      transition :invoiced => :paid
    end
    
    after_transition on: :mark_paid, do: :do_paid
  end
  
  protected
  def do_paid
    self.order.mark_paid
    self.update_attribute(:paid_at, Time.now)
  end
end