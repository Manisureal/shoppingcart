class CreateStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :stocks do |t|
      t.string :product_name
      t.decimal :cost_price
      t.integer :stock_change
      t.string :stock_message
      t.references :product, foreign_key: true
      t.references :consignment_item, foreign_key: true

      t.timestamps
    end
  end
end
