class AddBuyPriceToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :buy_price, :decimal
  end
end
