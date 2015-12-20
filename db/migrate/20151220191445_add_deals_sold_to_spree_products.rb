class AddDealsSoldToSpreeProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :deals_sold, :integer
  end
end
