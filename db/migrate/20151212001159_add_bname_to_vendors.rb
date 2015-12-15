class AddBnameToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :bname, :string
  end
end
