ActiveAdmin.register Stock do
  belongs_to :product
  permit_params :stock_change, :stock_message

  index do
    selectable_column
    columns_to_exclude = ["cost_price","updated_at"]
    (Stock.column_names - columns_to_exclude).each do |c|
      column c.to_sym
    end
    actions
    # column :description do
    #   raw "<a class='view_description button'>View Description</a>"
    # end
  end

  form do |f|
    f.inputs do
      f.input :product, collection: Product.all.map { |p| [p.description, p.id] }, input_html: { class: 'chosen-select', disabled: true }
      f.input :stock_change
      f.input :stock_message, as: :select, collection: ["Delivery", "Returned", "Stock Check"], input_html: { class: 'chosen-select' }
      # f.semantic_errors
    end
    actions
  end

  controller do
    def create
      create!do |format|
        format.html { redirect_to admin_products_path }
      end
    end
  end

end
