ActiveAdmin.register Product do
  menu if: proc{ current_user.admin? }
  actions :index, :show, :new, :create, :update, :edit
  permit_params :price, :description, :pack_size, :product_code, :minimum_stock, :buy_price, :active, :non_stock

  index do
    selectable_column
    column :id do |p|
      link_to p.id, admin_product_path(p)
    end
    column :product_code
    column :description
    column :pack_size
    column "Buy Price", :buy_price do |p|
      number_to_currency p.buy_price
    end
    column "Sale Price", :price do |p|
      number_to_currency p.price
    end
    column :current_stock
    column "Stock", :id do |p|
      link_to 'Add Stock', new_admin_product_stock_path(p)
    end
    column :active
    column :non_stock
    actions
  end

  form do |f|
    f.inputs "Product" do
      f.input :price, label: "Sale Price"
      f.input :description, input_html: { style: 'height: 50px' }
      f.input :pack_size
      f.input :product_code
      f.input :minimum_stock
      f.input :buy_price
      f.input :active
      f.input :non_stock, label: "Non-Stock Item"
    end
    f.actions
  end

end
