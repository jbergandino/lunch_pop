class AddCounterToSpreeProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :counter, :integer
  end
end
