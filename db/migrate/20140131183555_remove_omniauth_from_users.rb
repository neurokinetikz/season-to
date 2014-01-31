class RemoveOmniauthFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :omniauth_provider
    remove_column :users, :omniauth_uid
    remove_column :users, :omniauth_image
  end
end
