class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.string :subtitle
      t.string :description
      t.integer :price
      t.integer :vendor_id
      t.timestamp :expiration

      t.timestamps null: false
    end
  end
end
