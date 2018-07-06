class AddMinimumStockToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :minimum_stock, :integer
  end
end
