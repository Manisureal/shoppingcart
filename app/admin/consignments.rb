ActiveAdmin.register Consignment do
  permit_params :shipped_at, :tracking_no, :user, :order, :notes, :boxes
  menu parent: "Orders"

  # For MySQL Database - searches with LIKE which works fine when searching using equal(eq) in the search
  # filter :tracking_no_or_shipped_at_or_order_user_forname_or_order_user_surname_or_user_forname_or_user_surname_or_user_company_name_or_order_id_or_status_eq, as: :string, label: "Search Companies",
  #        placeholder: "e.g. Tracking, Customer, Admin, Company, ID, Status"
  filter :order_user_forname_or_order_user_surname_or_user_forname_or_user_surname_or_user_company_name_or_status_cont, as: :string, label: "Search Customer/Company/Admin",
         placeholder: "e.g. Customer, Admin, Company..."
  filter :tracking_no_or_shipped_at_or_order_id_eq, as: :string, label: "Search ID/Tracking",
         placeholder: "e.g. Tracking, ID..."

  # For PG Database - searches with ILIKE causes problems when using contains(cont) in the search - Need to input parameters with uppercase first letter
  # filter :order_user_forname_or_order_user_surname_or_user_forname_or_user_surname_or_user_company_name_or_status_cont, as: :string, label: "Search Companies"
  # filter :tracking_no_or_order_id_eq, as: :string, label: "Search Tracking or ID"


  index do
    selectable_column
    column "Consignment Summary", :id do |i|
      link_to "View Summary", admin_consignment_path(i)
    end
    column :shipped_at do |s|
      s.shipped_at.strftime("%A, %e %b - %H:%M %p")
    end
    column :tracking_no
    column "Admin", :user do |u|
      link_to (u.user.forname.to_s + " " + u.user.surname.to_s), admin_staff_path(u.user)
    end
    column "Customer", :user do |u|
      link_to (u.order.user.forname.to_s + " " + u.order.user.surname.to_s), admin_customer_path(u.order.user)
    end
    column "Company", :company do |co|
      link_to (co.order.company.name), admin_company_path(co.order.company)
    end
    column "Order #", sortable: :order_id do |o|
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

  action_item :view, only: :index, priority: 0 do
    link_to image_tag('search.png', height: 25), class: "search"
  end
end

