class AddParentSkuIdToSkus < ActiveRecord::Migration
  def change
  	add_column :skus, :parent_sku_id, :integer, :after => :product_id
  	add_index :skus, :parent_sku_id
  end
end
