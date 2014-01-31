class AddOmniauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :omniauth_provider, :string, after: :id
    add_column :users, :omniauth_uid, :string, after: :omniauth_provider
  end
end
