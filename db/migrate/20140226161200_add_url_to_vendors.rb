class AddUrlToVendors < ActiveRecord::Migration
  def change
  	add_column :vendors, :url, :string, after: :description
  end
end
