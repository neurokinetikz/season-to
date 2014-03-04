class Gift < Subscription
  @@mandrill = Mandrill::API.new 'wiogzUeHpLTaZz9vSORNxw'

  has_one :gift_recipient

  attr_accessible :gift_recipient, :order

  state_machine :state, :initial => :purchased do
    event :redeem do
      transition :purchased => :active
    end
    
    before_transition on: :redeem, do: :do_redeem
  end



  def do_redeem
    # update gift dates
    self.update_attributes(first_billing_date: Date.today, 
      billing_period_start_date: Date.today, 
      billing_period_end_date: Date.today.advance(months: self.plan.billing_cycle).advance(days: -1),
      paid_through_date: Date.today.advance(months: self.plan.billing_cycle).advance(days: -1)
    )

    # schedule shipments
    order = self.orders.first
    (0..(self.plan.billing_cycle-1)).to_a.each do |i|
      if i == 0
        # create first shipment
        first_shipment = Shipment.new(user: self.user, subscription: self, address: self.address, scheduled_at: Date.today)
        order.shipments << first_shipment
        first_shipment.line_items << LineItem.new(sku: Sku.find(55), sku_qty: 1)
        first_shipment.merchandise!
        first_shipment.ship!
      else
        # schedule remaining shipments
        order.shipments << Shipment.new(user: self.user, subscription: self, address: self.address, scheduled_at: Date.today.advance(months: i))
      end
    end

    self.gift_recipient.update_attribute(:redeemed_at, Time.now)
  end
end
