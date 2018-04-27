class CreateConsignmentItems < ActiveRecord::Migration[5.1]
  def change
    create_table :consignment_items do |t|
      t.integer :quantity
      t.references :consignment, foreign_key: true
      t.references :order_item, foreign_key: true

      t.timestamps
    end
  end
end
