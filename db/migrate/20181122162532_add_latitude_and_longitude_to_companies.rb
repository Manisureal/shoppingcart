class AddLatitudeAndLongitudeToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :latitude, :decimal
    add_column :companies, :longitude, :decimal
  end
end
