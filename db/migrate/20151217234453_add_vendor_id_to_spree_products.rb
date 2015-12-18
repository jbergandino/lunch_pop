class AddVendorIdToSpreeProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :vendor_id, :integer
  end
end
