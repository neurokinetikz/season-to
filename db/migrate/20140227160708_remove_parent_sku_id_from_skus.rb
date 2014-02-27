class RemoveParentSkuIdFromSkus < ActiveRecord::Migration
  def change
    remove_column :skus, :parent_sku_id
  end
end
