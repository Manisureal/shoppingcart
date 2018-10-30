ActiveAdmin.register Stock do
  belongs_to :product #optional: true
  permit_params :stock_change, :stock_message, :cost_price

  # index do
  #   selectable_column
  #   columns_to_exclude = ["cost_price","updated_at"]
  #   (Stock.column_names - columns_to_exclude).each do |c|
  #     column c.to_sym
  #   end
  #   actions
  #   # column :description do
  #   #   raw "<a class='view_description button'>View Description</a>"
  #   # end
  # end

  index do
    selectable_column
    column 'Stock ID', :id do |s|
      link_to(s.id,admin_product_stock_path(s.product.id,s.id))
    end
    column 'Order ID', :id do |s|
      s.consignment_item == nil ? "Stock Check" : link_to(s.consignment_item.consignment.order.id,admin_order_path(s.consignment_item.consignment.order.id))
    end
    column :cost_price do |s|
      number_to_currency s.cost_price
    end
    column :sale_price do |s|
      number_to_currency s.sale_price
    end
    column :stock_change
    column :stock_message
    column :product do |s|
      link_to(s.product.description,admin_product_path(s.product.id))
    end
    column :created_date
    actions
  end

  form do |f|
    f.inputs do
      f.input :product, collection: Product.all.map { |p| [p.description, p.id] }, input_html: { class: 'chosen-select', disabled: true }
      f.input :stock_change
      f.input :stock_message, as: :select, collection: ["Delivery", "Returned", "Stock Check"], input_html: { class: 'chosen-select' }
      f.input :cost_price
      # f.semantic_errors
    end
    actions
  end

  controller do
    def create
      @product = Product.find(params[:product_id])
      @product.stocks.new(permitted_params[:stock])
      if @product.non_stock == false
        @product.save
        redirect_to admin_products_path, notice: "Stock added for #{@product.description} successfully!"
      else
        # flash[:notice] = "You are not allowed to created stock for this item."
        redirect_to request.referrer, notice: "You cannot create stock for Non-Stock Items!"
        # flash[:error] = "You cannot create stock for Non-Stock Items!"
        # render :edit
      end
      # create!do |format|
      #   format.html { redirect_to admin_products_path }
      # end
    end
  end

end
