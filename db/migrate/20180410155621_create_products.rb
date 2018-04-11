class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.text :description
      t.integer :pack_size
      t.string :product_code

      t.timestamps
    end
  end
end
