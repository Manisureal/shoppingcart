ActiveAdmin.register Consignment do
  permit_params :shipped_at, :tracking_no, :user, :order

  index do
    selectable_column
    column :id do |i|
      link_to i.id, admin_consignment_path(i)
    end
    column :shipped_at
    column :tracking_no
    column :user
    column :order do |o|
      link_to o.order.id, admin_order_path(o.order.id)
    end
    column "Status", :consignment do |c|
      # if status == "Incomplete"
        status_tag(c.status, class: c.status == "Incomplete" ? "warning" : "done")
      # else
        # status_tag(o.order.status, class: o.order.status == "Ordered" ? "error" : "warning")
      # end
    end
    actions
  end

  show do
    render 'show_partial'
  end

end
