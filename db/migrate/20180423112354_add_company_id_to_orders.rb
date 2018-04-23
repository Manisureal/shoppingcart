class AddCompanyIdToOrders < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :company, foreign_key: true, index: true
  end
end
