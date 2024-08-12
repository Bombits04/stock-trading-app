class CreateStockPurchases < ActiveRecord::Migration[7.1]
  def change
    create_table :stock_purchases do |t|
      t.string :type_of_transaction
      t.float :purchase_amount
      t.references :user, null: false, foreign_key: true
      t.references :stock, null: false, foreign_key: true
      t.timestamps
    end
  end
end
