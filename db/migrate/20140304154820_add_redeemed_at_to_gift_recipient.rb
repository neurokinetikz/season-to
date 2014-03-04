class AddRedeemedAtToGiftRecipient < ActiveRecord::Migration
  def change
    add_column :gift_recipients, :redeemed_at, :datetime
  end
end
