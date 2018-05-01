class AddAdminNotesToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :admin_notes, :text
  end
end
