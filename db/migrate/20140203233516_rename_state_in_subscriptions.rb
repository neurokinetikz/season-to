class RenameStateInSubscriptions < ActiveRecord::Migration
  def change
    rename_column :subscriptions, :state, :status
  end
end
