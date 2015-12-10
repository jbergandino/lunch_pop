class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.string :username
      t.string :email
      t.string :password
      t.string :phone
      t.string :address
      t.string :city
      t.string :zip

      t.timestamps null: false
    end
  end
end
