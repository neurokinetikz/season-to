class RemoveInvoiceIdFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :invoice_id
  end
end
