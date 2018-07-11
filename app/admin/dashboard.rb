ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recent Orders", class: "orders" do
          table_for Order.where(status: ["Ordered", "Incomplete"]).order("id desc").limit(10) do
            column("Order#") { |order| link_to(order.id, admin_order_path(order)) }
            column("Order Date") { |order| order.created_at }
            column("Order Update Date") { |order| (order.updated_at == order.created_at) ? "Not Updated" : order.updated_at }
            column("Status") { |order| status_tag(order.status, class: order.status == "Ordered" ? "error" : "warning") }
            # column("Customer") { |order| link_to(order.user.forname.to_s + ' ' + order.user.surname.to_s, admin_customer_path(order.user)) }
            column("Customer") { |order| link_to(order.company.name.to_s, admin_company_path(order.company)) }
            # require
            column("Total")   { |order| number_to_currency order.total_price }
            column("Actions") { |order| link_to("Take Order", admin_order_path(order) + "?take_order=true" ) }
          end
        end
      end


      column do
        panel "Recent Customers" do
          table_for User.where(admin: false).order("id desc").limit(10).each do |user|

            column(:customer_name) { |user| (user.forname ? user.forname : 'Unknown') + ' ' + (user.surname ? user.surname : 'User')}

            column(:customer_email) { |user| link_to(user.email, admin_staff_path(user)) }
            column(:last_signed) { |user| user.last_sign_in_at }
          end
        end
      end
    end

    columns do
      column do
        panel "Stock Levels" do
          table_for Product.all.limit(11).each do |product|
            column(:product_code) { |product| link_to(product.product_code, admin_product_path(product))}
            column(:description) { |product| link_to(product.description, admin_product_path(product))}
            column(:pack_size)
            column(:price) { |product| number_to_currency product.price}
            column(:current_stock) { |product| label(product.current_stock,
              class: (product.current_stock > product.minimum_stock.to_i) ? "status good-level" :
               (product.current_stock == 0 || product.current_stock < 0) ? "status bad-level" :
               (product.current_stock.to_i <= product.minimum_stock.to_i) ? "status okay-level" : nil)
            }
            column() { |p| link_to("Add Stock", new_admin_product_stock_path(p))}
          end
        end
      end

      column do
        panel "Stock Search" do
          render 'date_range_search'
        end
      end
    end

  end

  # Custom Dashboard Controller Action/Method
  page_action :stock_search do
    if @date_from = params[:date_from].blank? ? nil : Date.parse(params[:date_from])
      respond_to do |format|
        format.js # actually means: if the client ask for js -> return file.js
      end
    end
  end

end

# Order.all.map do |o|
#   li link_to(o.user.forname, admin_order_path(o))

