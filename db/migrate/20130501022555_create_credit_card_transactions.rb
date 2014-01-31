class CreateCreditCardTransactions < ActiveRecord::Migration
  def change
    create_table :credit_card_transactions do |t|
      t.integer :user_id
      t.integer :credit_card_id
      t.string  :source_type
      t.integer :source_id
      t.string  :subject_type
      t.integer :subject_id
      t.string  :transaction_type
      t.string  :transaction_id
      t.integer :amount_cents
      t.string  :status
      t.string  :avs_error_response_code
      t.string  :avs_postal_code_response_code
      t.string  :avs_street_address_response_code
      t.string  :cvv_response_code
      t.string  :gateway_rejection_reason
      t.string  :processor_authorization_code
      t.string  :processor_response_code
      t.string  :processor_response_text
      t.timestamps
    end

    add_index :credit_card_transactions, :user_id
    add_index :credit_card_transactions, :credit_card_id
    add_index :credit_card_transactions, :status
    add_index :credit_card_transactions, :transaction_type
    add_index :credit_card_transactions, :transaction_id
    add_index :credit_card_transactions, [:source_type, :source_id]
    add_index :credit_card_transactions, [:subject_type, :subject_id]
  end
end
