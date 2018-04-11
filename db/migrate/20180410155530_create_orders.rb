class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :status
      t.decimal :total_price
      t.text :notes
      t.string :name
      t.text :address
      t.string :phone
      t.date :delivery_date

      t.timestamps
    end
  end
end
