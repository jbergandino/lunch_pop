class AddDealsSoldToMyproducts < ActiveRecord::Migration
  def change
    add_column :myproducts, :deals_sold, :integer
  end
end
