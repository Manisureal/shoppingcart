class AddIncompleteQuantityToOrderItem < ActiveRecord::Migration[5.1]
  def change
    add_column :order_items, :incomplete_quantity, :integer
  end
end
