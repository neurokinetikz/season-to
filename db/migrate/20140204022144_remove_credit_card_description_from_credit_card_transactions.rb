class RemoveCreditCardDescriptionFromCreditCardTransactions < ActiveRecord::Migration
  def change
    remove_column :credit_card_transactions, :credit_card_description
  end
end
