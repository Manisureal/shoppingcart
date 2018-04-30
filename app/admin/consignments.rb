ActiveAdmin.register Consignment do
  permit_params :shipped_at, :tracking_no, :user, :order

  index do
    selectable_column
    column "Consignment Summary", :id do |i|
      link_to "View Summary", admin_consignment_path(i)
    end
    column :shipped_at
    column :tracking_no
    column "Admin", :user do |u|
      link_to (u.user.forname + " " + u.user.surname), admin_user_path(u.user)
    end
    column "Customer", :user do |u|
      link_to (u.order.user.forname + " " + u.order.user.surname), admin_user_path(u.order.user)
    end
    column "Order #", :order do |o|
      link_to o.order.id, admin_order_path(o.order.id)
    end
    column "Status", :consignment do |c|
        status_tag(c.status, class: c.status == "Incomplete" ? "warning" : "done")
    end
    actions
  end

  show title: proc{|c| "Consignment##{c.id}" + " - " + "Order##{c.order_id}"} do
    render 'show_partial'
  end
end
