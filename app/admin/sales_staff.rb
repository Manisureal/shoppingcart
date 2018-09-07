ActiveAdmin.register User, as: "Sales Staff" do
  permit_params :forname, :surname, :email, :password, :password_confirmation, :sales, :company_id
  menu parent: "Users", if: proc{ current_user.admin? }
  breadcrumb {}

  controller do
    def scoped_collection
     end_of_association_chain.where(sales: true)
    end
  end

  index do
    selectable_column
    column :id
    column :email
    column :forname
    column :surname
    column :created_at
    column :admin
    column :sales
    column :company
    actions
  end

  form do |f|
    f.inputs "Identity" do
      if current_user.admin?
        f.input :company, as: :select, collection: Company.where(id: 96).collect { |c| [c.name,c.id]}
      end
      f.input :email
      f.input :forname
      f.input :surname
      f.input :password
    end
    # if f.object.new_record?
    # unless f.object.persisted?
    if current_user.admin?
      f.inputs "Sales" do
        f.input :sales
      end
    end
    # f.actions
    f.actions do
      f.action :submit
      f.action :cancel, as: :link, label: "Cancel", button_html: { class: "cancel-btn" }
      # f.cancel_link({action: "back"})
    end
  end

end

