class CreateMyproducts < ActiveRecord::Migration
  def change
    create_table :myproducts do |t|
      t.string :title
      t.string :subtitle
      t.string :description
      t.integer :price
      t.integer :vendor_id
      t.datetime :expiration
      t.integer :counter

      t.timestamps null: false
    end
  end
end
