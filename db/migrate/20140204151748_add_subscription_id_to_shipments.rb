class AddSubscriptionIdToShipments < ActiveRecord::Migration
  def change
    add_column :shipments, :subscription_id, :integer, after: :user_id
    add_index :shipments, :subscription_id
  end
end
