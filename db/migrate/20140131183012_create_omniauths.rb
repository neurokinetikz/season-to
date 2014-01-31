class CreateOmniauths < ActiveRecord::Migration
  def change
    create_table :omniauths do |t|
      t.integer :user_id
      t.string  :provider
      t.string  :uid
      t.string  :image
      t.string  :name
      t.string  :nickname
      t.timestamps
    end
    
    add_index :omniauths, :user_id
    add_index :omniauths, [:provider, :uid]
  end
end
