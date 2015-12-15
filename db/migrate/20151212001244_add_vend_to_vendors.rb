class AddVendToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :vend, :boolean
  end
end
