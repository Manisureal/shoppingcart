class AddNonStockToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :non_stock, :boolean, default: false
  end
end
