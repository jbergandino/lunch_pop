class CreateCustCards < ActiveRecord::Migration
  def change
    create_table :cust_cards do |t|
      t.string :card_company
      t.string :card_num
      t.string :card_security
      t.string :card_exp
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
