class AddStatusToConsignment < ActiveRecord::Migration[5.1]
  def change
    add_column :consignments, :status, :string
  end
end
