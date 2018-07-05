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
    column :current_stock
    column "Stock", :id do |p|
      link_to 'Add Stock', new_admin_product_stock_path(p)
    end
    actions
  end

end
