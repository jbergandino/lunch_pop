class AddVendToUsers < ActiveRecord::Migration
  def change
    add_column :users, :vend, :boolean
  end
end
