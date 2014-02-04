class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.string    :itemizable_type
      t.integer   :itemizable_id
      t.integer   :sku_id
      t.integer   :sku_qty
      t.integer   :unit_price_cents
      t.integer   :unit_discount_cents
      t.timestamps
    end
    
    add_index :line_items, [:itemizable_type, :itemizable_id]
    add_index :line_items, :sku_id
  end
end
