class ChangeDecimalToFloatInStocks < ActiveRecord::Migration[5.2]
  def change
    change_column :stocks, :cost_price, :float
    change_column :stocks, :sale_price, :float
  end
end
