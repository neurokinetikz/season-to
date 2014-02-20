class AddAddressToSubscription < ActiveRecord::Migration
  def change
  	add_column :subscriptions, :address_id, :integer, after: :plan_id

  	add_index :subscriptions, :address_id
  end
end
