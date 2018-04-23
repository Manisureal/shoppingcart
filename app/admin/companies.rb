ActiveAdmin.register Company do
  permit_params :name, :address, :postcode, :contact_name, :phone, :fax, :email, :xero_id
end
