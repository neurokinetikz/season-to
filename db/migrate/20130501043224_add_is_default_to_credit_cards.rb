class AddIsDefaultToCreditCards < ActiveRecord::Migration
  def change
    add_column :credit_cards, :is_default, :boolean, :default => false, :after => :expiration_year
  end
end
