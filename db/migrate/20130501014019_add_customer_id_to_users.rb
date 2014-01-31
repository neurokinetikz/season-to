class AddCustomerIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :customer_id, :string, :after => :id
    add_index :users, :customer_id
  end
end
