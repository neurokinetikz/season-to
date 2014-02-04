class AddTokenToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :token, :string, after: :plan_id
    add_index :subscriptions, :token
  end
end
