ActiveAdmin.register Company do
  permit_params :name, :address, :postcode, :contact_name, :phone, :fax, :email, :xero_id, :account_owner

  menu if: proc{ current_user.admin? }

  # For this tab the following serch filter works fine
  filter :name_or_address_or_postcode_or_contact_name_or_phone_or_email_cont, as: :string, label: "Search Companies", placeholder: "e.g. Name, Address, P.O., Contact, Phone, Email"
  # filter :name, as: :select, label: "Search by Name", prompt: "Select or Type", collection: Company.all.collect { |c| c.name }, input_html: { class: 'chosen-select2' }
  # filter :address, as: :select, label: "Search by Address", prompt: "Select or Type", collection: Company.all.collect { |c| c.address }, input_html: { class: 'chosen-select2' }
  # filter :postcode, as: :select, label: "Search by Postcode", prompt: "Select ot Type", collection: Company.all.collect { |c| c.postcode }, input_html: { class: 'chosen-select2' }
  # filter :contact_name, as: :select, label: "Search by Contact Name", prompt: "Select or Type", collection: Company.all.collect { |c| c.postcode}, input_html: { class: 'chosen-select2' }
  # filter :phone, as: :select, label: "Search by Phone Number", prompt: "Select or Type", collection: Company.all.collect { |c| c.phone }, input_html: { class: 'chosen-select2' }
  # filter :email, as: :select, label: "Search by Email", prompt: "Select or Type", collection: Company.all.collect { |c| c.email }, input_html: { class: 'chosen-select2' }

  index do
    selectable_column
    column :id do |c|
      link_to c.id, admin_company_path(c)
    end
    column :name
    column :address
    column :postcode
    column :contact_name
    column :phone
    column :email
    actions
  end

  show do
    attributes_table do
      row :name
      row :address
      row :postcode
      row :contact_name
      row :phone
      row :email
      row :created_at
      row :updated_at
      row :account_owner
    end

    panel "Users" do
      table_for company.users do
        column :id do |c|
          if c.admin?
            link_to c.id, admin_staff_path(c)
          else
            link_to c.id, admin_customer_path(c)
          end
        end
        column :email
        column :forname
        column :surname
        column :created_at
        column :action do |c|
          links = link_to I18n.t('active_admin.view'), c.admin? ? admin_staff_path(c) : admin_customer_path(c)
          links += " "
          links += link_to I18n.t('active_admin.edit'), edit_admin_customer_path(c)
          links += " "
          links += link_to "Delete", admin_customer_path(c), method: :delete, data: { confirm: 'Are you sure?' }
          links
        end
      end
    end

    panel "Orders" do
      paginated_collection(company.orders.page(params[:company_orders_page]).per(15), param_name: 'company_orders_page') do
        table_for company.orders.order("id desc").page(params[:company_orders_page]).per(15) do
          column :id do |o|
            link_to o.id, admin_order_path(o.id)
          end
          column :status do |s|
            status_tag(s.status, class: (s.status == "Ordered") ? "error" : (s.status == "In Progress") ? "blue" : (s.status == "Incomplete") ? "warning" : (s.status == "Cancelled") ? "pink" : "done")
          end
          column :total_price
          column :created_at
          column :user
          column :taken_by
          column :action do |o|
            links = link_to I18n.t('active_admin.view'), admin_order_path(o)
            links += " "
            links += link_to I18n.t('active_admin.edit'), edit_admin_order_path(o)
            links += " "
            links += link_to "Delete", admin_order_path(o), method: :delete, data: { confirm: "Are you sure you want to delete Order# #{o.id}?" }
            links
          end
        end
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Details" do
      f.input :name
      f.input :address, as: :text
      f.input :postcode
      f.input :contact_name
      f.input :phone
      f.input :fax
      f.input :email
      # f.input :account_owner, as: :select, collection: ["Caremeds","Kristian Bade"]
      f.input :account_owner, as: :select, collection: User.where(sales: true).collect { |u| [u.forname, u.id] }, include_blank: "Caremeds"
      # f.input :account_manager_id, as: :select, collection: User.where(sales: true).collect { |u| [u.forname, u.id] }, include_blank: "Caremeds"
      f.actions
    end
  end

  action_item :view, only: :index, priority: 0 do
    link_to image_tag('search.png', height: 25), class: "search"
  end

  controller do
    def new
      @company = Company.new
      unless params[:go_cardless_reference].blank?
        if Rails.env == "development"
          client = GoCardlessPro::Client.new(
            access_token: "sandbox_HF_Aa3qDC9x2Ie6EQJ-YVIQ0o4GMarEtpur6whQ7",
            environment: :sandbox
          )
        else
          client = GoCardlessPro::Client.new(
            access_token: "sandbox_HF_Aa3qDC9x2Ie6EQJ-YVIQ0o4GMarEtpur6whQ7"
          )
        end

        begin
          customer = client.customers.get(params[:go_cardless_reference])
          @company.name = customer.company_name
          @company.address = customer.address_line1.to_s + ' ' + customer.address_line2.to_s + ' ' + customer.address_line3.to_s
          @company.postcode = customer.postal_code
          @company.contact_name = customer.given_name + ' ' + customer.family_name
          # @company.phone = customer[phone_number]
          @company.email = customer.email
        rescue GoCardlessPro::InvalidApiUsageError => e
          e.error['errors'].each do |error|
            @company.errors.add('GoCardless Import Error:', error['reason'])
          end
        end
      end
    end

    def create
      @company = Company.new(permitted_params[:company])
      if @company.save
        split_contact_name = @company.contact_name.split()
        if split_contact_name.length > 2
          @company.users.create!(email:@company.email,forname:split_contact_name[0..1].join(' '),surname:split_contact_name[2..5].join(' '),company_id:@company.id,password:"PharmaTempPass",password_confirmation:"PharmaTempPass")
        else
          @company.users.create!(email:@company.email,forname:split_contact_name[0],surname:split_contact_name[1],company_id:@company.id,password:"PharmaTempPass",password_confirmation:"PharmaTempPass")
        end
      redirect_to admin_companies_path, notice: "#{@company.name} and First User created Successfully!"
      else
        render :new
      end
    end

  end

  collection_action :import_company do
    render partial: "import_company_modal"
  end

  action_item :import_company_button do
    link_to "Import Company", import_company_admin_companies_path, remote: true
  end


end

