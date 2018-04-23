class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.text :address
      t.string :postcode
      t.string :contact_name
      t.string :phone
      t.string :fax
      t.string :email
      t.string :xero_id

      t.timestamps
    end
  end
end
