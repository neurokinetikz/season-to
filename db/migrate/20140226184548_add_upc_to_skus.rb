class AddUpcToSkus < ActiveRecord::Migration
  def change
    add_column :skus, :upc, :string, after: :parent_sku_id

    add_index :skus, :upc
  end
end
