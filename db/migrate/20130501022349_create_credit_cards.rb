class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.integer :user_id
      t.string  :token
      t.string  :card_type
      t.string  :last4
      t.integer :expiration_month
      t.integer :expiration_year
      t.timestamps
    end

    add_index :credit_cards, :user_id
  end
end
