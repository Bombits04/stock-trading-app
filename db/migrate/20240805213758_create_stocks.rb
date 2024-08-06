class CreateStocks < ActiveRecord::Migration[7.1]
  def change
    create_table :stocks do |t|
      t.string :company_name
      t.integer :stock_quantity
      t.float :price_per_stock

      t.timestamps
    end
  end
end
