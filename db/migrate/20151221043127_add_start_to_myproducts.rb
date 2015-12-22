class AddStartToMyproducts < ActiveRecord::Migration
  def change
    add_column :myproducts, :start, :datetime
  end
end
