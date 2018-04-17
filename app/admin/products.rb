ActiveAdmin.register Product do
  permit_params :name, :price, :description, :pack_size, :product_code
end
