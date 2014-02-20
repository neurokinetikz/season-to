class RenameSubscriptionStatus < ActiveRecord::Migration
  def change
  	rename_column :subscriptions, :status, :state
  end
end
