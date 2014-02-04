class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer   :order_id
      t.integer   :user_id
      t.string    :state
      t.integer   :subtotal_cents
      t.integer   :tax_cents
      t.integer   :shipping_cents
      t.integer   :discount_cents
      t.integer   :total_cents
      t.timestamps
      t.datetime  :due_at
      t.datetime  :paid_at
    end
    
    add_index :invoices, :order_id
    add_index :invoices, :user_id
    add_index :invoices, :state
  end
end
