class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string  :code
      t.string  :name
      t.text    :description
      t.integer :price_cents
      t.integer :billing_cycle
      t.timestamps
    end
    
    add_index :plans, :code
  end
end
