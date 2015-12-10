class CreatePayables < ActiveRecord::Migration
  def change
    create_table :payables do |t|
      t.integer :product_id
      t.integer :vendor_id

      t.timestamps null: false
    end
  end
end
