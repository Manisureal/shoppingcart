class AddSalesToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :sales, :boolean, default: false
  end
end
