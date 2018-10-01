ActiveAdmin.register User, as: "Sales Staff" do
  permit_params :forname, :surname, :email, :password, :password_confirmation, :sales, :commission_rate, :company_id
  menu parent: "Users", if: proc{ current_user.admin? }
  breadcrumb {}

  # actions :all

  controller do

    def update
      # Used to check if the user is wanting to update their password
      if current_user.admin?
        model = :user

        if params[model][:password].blank?
          %w(password password_confirmation).each { |p| params[model].delete(p) }
        end
        super
      end

      if current_user.sales?
        update! do |success, error|
          success.html {redirect_to admin_sales_dashboard_path}
          error.html {super}
        end
      end
    end

    def scoped_collection
     end_of_association_chain.where(sales: true)
    end

    # def action_methods
    #   if User.find(current_user.sales?)
    #     super - ['new', 'create', 'index', 'destroy']
    #     # raise ActionController::RoutingError.new('Restricted Route') unless Admin::SalesStaffsController.controller_path+"/#{current_user.id}/edit" == "admin/sales_staffs/#{current_user.id}/edit"
    #   else
    #     super
    #   end
    # end

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
      f.inputs "Commision" do
        f.input :commission_rate
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

