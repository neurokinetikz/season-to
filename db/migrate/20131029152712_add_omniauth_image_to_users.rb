class AddOmniauthImageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :omniauth_image, :string, after: :omniauth_uid
    
    add_index :users, [:omniauth_provider, :omniauth_uid]
  end
end
