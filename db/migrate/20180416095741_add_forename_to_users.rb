class AddForenameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :forname, :string
  end
end
