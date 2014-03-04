class AddCodeToGiftRecipients < ActiveRecord::Migration
  def change
    add_column :gift_recipients, :code, :string, after: :id
    add_index :gift_recipients, :code
  end
end
