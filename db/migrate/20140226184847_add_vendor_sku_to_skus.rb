class AddVendorSkuToSkus < ActiveRecord::Migration
  def change
    add_column :skus, :vendor_code, :string, after: :upc
    add_index :skus, :vendor_code
  end
end
