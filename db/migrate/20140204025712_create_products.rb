class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :vendor_id
      t.string  :name
      t.text    :description
      t.timestamps
    end
    
    add_index :products, :vendor_id
  end
end
