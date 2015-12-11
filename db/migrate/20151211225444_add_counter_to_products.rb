class AddCounterToProducts < ActiveRecord::Migration
  def change
    add_column :products, :counter, :integer
  end
end
