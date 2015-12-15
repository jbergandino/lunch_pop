class AddContactToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :contact, :string
  end
end
