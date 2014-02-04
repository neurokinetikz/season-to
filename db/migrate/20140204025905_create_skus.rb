class CreateSkus < ActiveRecord::Migration
  def change
    create_table :skus do |t|
      t.integer   :product_id
      t.string    :code
      t.string    :name
      t.text      :description
      t.integer   :unit_price_cents
      t.timestamps
    end
    
    add_index :skus, :product_id
    add_index :skus, :code
    
  end
end
