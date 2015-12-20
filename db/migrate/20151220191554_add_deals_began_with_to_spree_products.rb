class AddDealsBeganWithToSpreeProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :deals_began_with, :integer
  end
end
