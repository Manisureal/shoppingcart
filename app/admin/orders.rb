ActiveAdmin.register Order do

  permit_params :status, :total_price, :notes, :name, :address, :phone, :delivery_date, :company_id, :taken_by, :admin_notes, :boxes, :user_id,
    order_items_attributes: [:id, :product_id, :quantity, :to_dispatch]

  index do
    selectable_column
    column "Order#", :id do |o|
      link_to o.id, admin_order_path(o)
    end
    column :status do |s|
      status_tag(s.status, class: (s.status == "Ordered") ? "error" : (s.status == "In Progress") ? "blue" : (s.status == "Incomplete") ? "warning" : "done")
    end
    column :total_price do |tp|
      number_to_currency tp.total_price
    end
    column :created_at
    column "Customer", :user_id do |u|
      link_to u.user.forname.to_s + " " + u.user.surname.to_s, admin_customer_path(u.user_id)
    end
    column :company
    column "Admin Assigned", :taken_by
    actions
  end

  # Scoped Statuses
  scope :all, group: :status
  scope "Ordered", :all, group: :status do |order|
    order.where(status: "Ordered")
  end
  scope "In Progress", :all, group: :status do |order|
    order.where(status: "In Progress")
  end
  scope "Incomplete", :all, group: :status do |order|
    order.where(status: "Incomplete")
  end
  scope "Completed", :all, group: :status do |order|
    order.where(status: ["Completed", "Dispatched"])
  end

  # Scoped Taken By
  john = ""
  amanda = ""
  andy = ""
  User.where(admin: true).map.each do |au|
    john += au.forname + " " + au.surname  if au.id == 102
    amanda += au.forname + " " + au.surname if au.id == 100
    andy += au.forname + " " + au.surname if au.id == 97
  end

  scope "Andy Richards", :taken_by, group: :taken_by do |order|
    order.where(taken_by: andy)
  end
  scope "John Rowley", :taken_by, group: :taken_by do |order|
    order.where(taken_by: john)
  end
  scope "Amanda Rowley", :taken_by, group: :taken_by do |order|
    order.where(taken_by: amanda)
  end

  show do
    @order = Order.find(params[:id])
    render 'show_partial', { order: @order }
  end

  form do |f|
    f.inputs "Order" do
      if f.object.new_record?
        f.input :company, as: :select, collection: Company.all.collect { |c| [c.name,c.id]}, input_html: { class: "chosen-select company-select" }
        f.input :user, as: :select, collection: User.all.collect { |u| [u.forname,u.id, class: "user_selector company-#{u.company_id}"]}, input_html: { class: "user-select"}
        f.input :status, prompt: "Please Choose", collection: ["Ordered","In Progress", "Completed", "Dispatched", "Cancelled", "Incomplete"]
        f.input :notes, input_html: { style: 'height: 50px' }
        # f.input :address, as: :select, collection: User.all.collect { |u| [u.company.address,u.company.id, class: "address-selector"] }, input_html: { class: "company-address-select" }
        f.input :address, as: :select, collection: Company.all.collect { |c| [c.address,c.id, class: "address-selector address-selector-#{c.id}"] }, input_html: { class: "company-address-select" }
        # f.input :address, as: :select, collection: Company.all.collect { |c| [c.address,c.id, class: "user_selector company-#{c.id}"]}, input_html: { class: "company-select" }
        # f.input :address, input_html: { style: 'height: 50px' }
      else
        # f.label :company, class: 'f-label'
        # f.select :company,
        #          Company.all.collect { |c| [c.name, c.id ]},
        #          {include_blank: true},
        #          {
        #           class: 'chosen-select company-select',
        #           data: { placeholder: "Some Company" }
        #          }
        f.input :company, as: :select, collection: Company.all.collect { |c| [c.name,c.id]}, input_html: { class: "chosen-select company-select" }
        f.input :user, as: :select, collection: User.all.collect { |u| [u.forname,u.id, class: "user_selector company-#{u.company_id}"]}, input_html: { class: "user-select"}
        # f.label :user, class: 'f-label margin-top'
        # f.select :user_id,
        #         User.all.collect { |u| [u.forname, u.id, class: "user_selector company-#{u.company_id}"]},
        #         { prompt: "Please Choose" },
        #         { class: "user-select chosen-select" }
        f.input :status, prompt: "Please Choose", collection: ["Ordered","In Progress", "Completed", "Dispatched", "Cancelled", "Incomplete"]
        f.input :total_price
        f.input :notes, input_html: { style: 'height: 50px' }
        # f.input :name
        f.input :address, input_html: { style: 'height: 50px' }
        # f.input :phone
        # f.input :delivery_date
        f.input :taken_by
      end
    end

    # f.inputs "Order Items" do
      panel "Order Items" do
        render 'edit_order_items_form'
      # end
      # f.has_many :order_items, allow_destroy: true do |oi|
      #   oi.input :quantity
      #   oi.input :product, label: "Product Code", as: :select, collection: Product.all.collect { |p| [p.product_code,p.id]}
      #   # oi.input :product, label: "Product Description", as: :select, collection: Product.all.collect { |p| [p.product_code,p.id]}, input_html: {disabled:true}
        f.actions
      end
    # end
  end

  controller do
    def new
      @order = Order.new
      5.times do
        @order_items = @order.order_items.new
      end

    end

    def create
      create!do |format|
        format.html { redirect_to admin_root_path, notice: "Order# #{@order.id} was successfully Created!" }
      end
    end

    def show
      if params[:take_order] == "true"
        order = Order.find(params[:id])
        order.status = "In Progress"
        order.taken_by = current_user.forname + " " + current_user.surname
        order.save
      end
    end

    def edit
      @order = Order.find(params[:id])
      @order_items = @order.order_items
      (5 - @order.order_items.count).times do
        @order.order_items.new
      end
    end

    def update
      @consignment = Consignment.last
      @order = Order.find(params[:id])
      if @order.update_attributes(permitted_params[:order])
        # @check_oi_quantities_disp = @order.order_items.each { |oi| @res = !oi.quantity_dispatched.blank?  }
        if params[:commit] == 'Dispatch Order'
          if @order.status == "Incomplete" #and @res
            @new_consignment_for_incmp = Consignment.create!(user: current_user, order: @order, shipped_at: Time.now, tracking_no: "", status: @order.status)
            @new_consignment_for_incmp.order.order_items.each do |oi|
              nci = @new_consignment_for_incmp.consignment_items.new
              nci.quantity = oi.incomplete_quantity
              nci.order_item_id = oi.id
              @new_consignment_for_incmp.consignment_items << nci
            end
            redirect_to admin_root_path, alert: "Order# #{@order.id} has been marked as Incomplete"

          elsif @order.status == "Dispatched"
            @new_consignment_for_disptch = Consignment.create!(user: current_user, order: @order, shipped_at: Time.now, tracking_no: "", status: @order.status)
            @new_consignment_for_disptch.order.order_items.each do |ci|
              nci = @new_consignment_for_disptch.consignment_items.new
              nci.quantity = ci.incomplete_quantity
              nci.order_item_id = ci.id
              @new_consignment_for_disptch.consignment_items << nci
            end
            redirect_to admin_root_path, notice: "Order# #{@order.id} was successfully marked as Dispatched"
          end
        end
        if params[:commit] == 'Update Order'
          redirect_to admin_root_path, notice: "Order# #{@order.id} was successfully Updated"
        end

      else
        render :edit
      end
    end
  end

  action_item :view, only: :index, priority: 0 do
    link_to image_tag('search.png', height: 25), class: "search"
  end

end

