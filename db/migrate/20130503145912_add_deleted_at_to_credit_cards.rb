class AddDeletedAtToCreditCards < ActiveRecord::Migration
  def change
    add_column :credit_cards, :deleted_at, :datetime, :after => :updated_at
  end
end
