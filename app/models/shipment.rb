class Shipment < ActiveRecord::Base
  belongs_to :user
  belongs_to :subscription
  belongs_to :order
  belongs_to :address

  has_many :line_items, as: :itemizable
  
  attr_accessible :user, :subscription, :order, :address, :scheduled_at
  
  state_machine :state, :initial => :pending do
    event :merchandise do
      transition pending: :ready 
    end

    event :ship do
      transition ready: :shipped
    end

    event :deliver do
      transition shipped: :delivered
    end

    before_transition on: :merchandise, do: :do_merchandise
    after_transition on: :ship, do: :do_ship
    after_transition on: :deliver, do: :do_deliver
  end

  protected
    def do_merchandise
    end

    def do_ship
      self.update_attribute(:shipped_at, Time.now)
    end

    def do_deliver
    end
end
