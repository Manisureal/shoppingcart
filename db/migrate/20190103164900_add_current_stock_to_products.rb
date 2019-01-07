class AddCurrentStockToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :current_stock, :integer
  end
end
