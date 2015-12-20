class AddDealsBeganWithToMyproducts < ActiveRecord::Migration
  def change
    add_column :myproducts, :deals_began_with, :integer
  end
end
