class AddExpirationToSpreeProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :expiration, :datetime
  end
end
