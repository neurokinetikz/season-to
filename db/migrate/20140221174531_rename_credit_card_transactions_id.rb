class RenameCreditCardTransactionsId < ActiveRecord::Migration
  def change
  	rename_column :credit_card_transactions, :transaction_id, :token
  end
end
