class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string  :type
      t.string  :addressable_type
      t.integer :addressable_id
      t.string  :first_name
      t.string  :last_name
      t.string  :address1
      t.string  :address2
      t.string  :city
      t.string  :state
      t.string  :zip
      t.boolean :is_default
      t.timestamps
    end
    
    add_index :addresses, :type
    add_index :addresses, [:addressable_type, :addressable_id]
  end
end
