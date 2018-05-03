ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recent Orders" do
          table_for Order.where(status: ["Ordered", "Incomplete"]).order("id desc").limit(10) do
            column("Order#") { |order| link_to(order.id, admin_order_path(order)) }
            column("Order Date") { |order| order.created_at }
            column("Order Update Date") { |order| (order.updated_at == order.created_at) ? "Not Updated" : order.updated_at }
            column("Status") { |order| status_tag(order.status, class: order.status == "Ordered" ? "error" : "warning") }
            column("Customer") { |order| link_to(order.user.forname + ' ' + order.user.surname, admin_user_path(order.user)) }
            # require
            column("Total")   { |order| number_to_currency order.total_price }
            column("Actions") { |order| link_to("Take Order", admin_order_path(order) + "?take_order=true" ) }
          end
        end
      end


      column do
        panel "Recent Customers" do
          table_for User.order("id desc").limit(10).each do |user|
            column(:customer_name) { |user| user.forname + ' ' + user.surname }
            column(:customer_email) { |user| link_to(user.email, admin_user_path(user)) }
            column(:last_signed) { |user| user.last_sign_in_at }
          end
        end
      end
    end
  end
end


# Order.all.map do |o|
#   li link_to(o.user.forname, admin_order_path(o))

