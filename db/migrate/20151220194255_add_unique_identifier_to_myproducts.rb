class AddUniqueIdentifierToMyproducts < ActiveRecord::Migration
  def change
    add_column :myproducts, :unique_identifier, :string
  end
end
