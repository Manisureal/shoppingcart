class AddCommissionRateToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :commission_rate, :integer
  end
end
