class AddQuantityDispatchedToOrderItems < ActiveRecord::Migration[5.1]
  def change
    add_column :order_items, :quantity_dispatched, :integer
  end
end
