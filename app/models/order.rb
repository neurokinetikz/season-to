class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :subscription
  belongs_to :address

  has_one :invoice
  
  attr_accessible :user, :subscription, :address
  
  has_many :line_items, as: :itemizable
  has_many :shipments
  has_many :credit_card_transactions, as: :subject
  
  state_machine :state, :initial => :ordered do
    event :mark_invoiced do
      transition :ordered => :invoiced
    end

    event :mark_paid do
      transition :invoiced => :paid
    end

    before_transition on: :mark_invoiced, do: :do_invoice
    after_transition on: :mark_paid, do: :do_paid

  end

  def do_invoice
    subtotal = Money.new('0.00'); self.line_items.collect{|li| subtotal += li.sku.unit_price*li.sku_qty}
    self.invoice = Invoice.create(user: self.user, subtotal: subtotal, total: subtotal, due_at: Time.now)
  end

  def do_paid
    # TODO send receipt email
  end
end
