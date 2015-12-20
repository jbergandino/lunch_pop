class AddUniqueIdentifierToSpreeProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :unique_identifier, :string
  end
end
