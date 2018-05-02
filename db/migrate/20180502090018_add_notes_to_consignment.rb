class AddNotesToConsignment < ActiveRecord::Migration[5.1]
  def change
    add_column :consignments, :notes, :text
  end
end
