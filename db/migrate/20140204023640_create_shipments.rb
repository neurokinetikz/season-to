class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.string    :state
      t.integer   :user_id
      t.integer   :order_id
      t.integer   :address_id
      t.string    :carrier
      t.string    :tracking_number
      t.date      :scheduled_at
      t.datetime  :shipped_at
      t.datetime  :delivered_at
      t.timestamps
    end
    
    add_index :shipments, :state
    add_index :shipments, :user_id
    add_index :shipments, :order_id
    add_index :shipments, :address_id
    add_index :shipments, :scheduled_at
  end
end
