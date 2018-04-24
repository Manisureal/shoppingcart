class AddTakenByToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :taken_by, :string
  end
end
