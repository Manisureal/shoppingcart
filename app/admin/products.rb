ActiveAdmin.register Product do
  permit_params :price, :description, :pack_size, :product_code

  index do
    selectable_column
    column :id do |p|
      link_to p.id, admin_product_path(p)
    end
    column :price do |p|
      number_to_currency p.price
    end
    column :description
    column :pack_size
    column :product_code
    actions
  end
end
