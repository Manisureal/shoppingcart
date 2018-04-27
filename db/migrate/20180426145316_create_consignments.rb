class CreateConsignments < ActiveRecord::Migration[5.1]
  def change
    create_table :consignments do |t|
      t.datetime :shipped_at
      t.string :tracking_no
      t.references :user, foreign_key: true
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
