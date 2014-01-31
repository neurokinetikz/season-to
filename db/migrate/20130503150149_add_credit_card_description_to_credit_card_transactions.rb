class AddCreditCardDescriptionToCreditCardTransactions < ActiveRecord::Migration
  def change
    add_column :credit_card_transactions, :credit_card_description, :string, :after => :credit_card_id
  end
end
