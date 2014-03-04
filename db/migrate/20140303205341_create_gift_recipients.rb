class CreateGiftRecipients < ActiveRecord::Migration
  def change
    create_table :gift_recipients do |t|
      t.integer :gift_id
      t.integer :user_id
      t.string  :first_name
      t.string  :last_name
      t.string  :email
      t.text    :message
      t.timestamps
    end

    add_index :gift_recipients, :gift_id
    add_index :gift_recipients, :user_id
  end
end
