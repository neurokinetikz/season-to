class AddCreditCardIdToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :credit_card_id, :integer, after: :plan_id
    add_index :subscriptions, :credit_card_id
  end
end
