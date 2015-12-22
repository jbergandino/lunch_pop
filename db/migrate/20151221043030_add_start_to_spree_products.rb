class AddStartToSpreeProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :start, :datetime
  end
end
