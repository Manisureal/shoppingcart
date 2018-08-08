ActiveAdmin.register Company do
  permit_params :name, :address, :postcode, :contact_name, :phone, :fax, :email, :xero_id, :account_owner

  filter :name_or_address_or_postcode_or_contact_name_or_phone_or_email_cont, as: :string, label: "Search Companies"
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
        column :actions do |c|
          links = link_to I18n.t('active_admin.view'), c.admin? ? admin_staff_path(c) : admin_customer_path(c)
          links += " "
          links += link_to I18n.t('active_admin.edit'), edit_admin_customer_path(c)
          links += " "
          links += link_to "Delete", admin_customer_path(c), method: :delete, data: { confirm: 'Are you sure?' }
          links
        end
      end
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :address, as: :text
      f.input :postcode
      f.input :contact_name
      f.input :phone
      f.input :fax
      f.input :email
      f.input :account_owner, as: :select, collection: ["Caremeds","Sales - Kristian Bade"]
      f.actions
    end
  end

  action_item :view, only: :index, priority: 0 do
    link_to image_tag('search.png', height: 25), class: "search"
  end
end

