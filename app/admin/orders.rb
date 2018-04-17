ActiveAdmin.register Order do
  permit_params :status, :total_price, :notes, :name, :address, :phone, :delivery_date
end
