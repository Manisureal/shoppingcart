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
            column("Customer") { |order| link_to(order.user.forname + ' ' + order.user.surname, admin_staff_path(order.user)) }
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
            column(:description) { |product| link_to(product.description, admin_product_path(product))}
            column(:pack_size)
            column(:price) { |product| number_to_currency product.price}
            column(:current_stock) { |product| status_tag(product.current_stock, class: "stock-level")}
            column() { |p| link_to("Add Stock", new_admin_product_stock_path(p))}
          end
        end
      end
    end
  end
end


# Order.all.map do |o|
#   li link_to(o.user.forname, admin_order_path(o))

