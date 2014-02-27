class AddTypeToSku < ActiveRecord::Migration
  def change
    add_column :skus, :type, :string, after: :id
    add_index :skus, :type
  end
end
