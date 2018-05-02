class AddBoxesToConsignment < ActiveRecord::Migration[5.1]
  def change
    add_column :consignments, :boxes, :integer
  end
end
