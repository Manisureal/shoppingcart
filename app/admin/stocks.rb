ActiveAdmin.register Stock do
  belongs_to :product
  permit_params :stock_change, :stock_message

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
