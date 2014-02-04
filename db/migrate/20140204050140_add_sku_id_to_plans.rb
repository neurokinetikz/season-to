class AddSkuIdToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :sku_id, :integer, after: :id
    add_index :plans, :sku_id
  end
end
