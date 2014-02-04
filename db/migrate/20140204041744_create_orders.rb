class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer   :user_id
      t.integer   :address_id
      t.integer   :invoice_id
      t.integer   :subscription_id
      t.string    :state
      t.timestamps
    end
    
    add_index :orders, :user_id
    add_index :orders, :address_id
    add_index :orders, :invoice_id
    add_index :orders, :subscription_id
    add_index :orders, :state
  end
end
