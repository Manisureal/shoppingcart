ActiveAdmin.register Company do
  permit_params :name, :address, :postcode, :contact_name, :phone, :fax, :email, :xero_id, :account_owner

  filter :name, as: :select, label: "Search by Name", prompt: "Select or Type", collection: Company.all.collect { |c| c.name }, input_html: { class: 'chosen-select2' }
  filter :address, as: :select, label: "Search by Address", prompt: "Select or Type", collection: Company.all.collect { |c| c.address }, input_html: { class: 'chosen-select2' }
  filter :postcode, as: :select, label: "Search by Postcode", prompt: "Select ot Type", collection: Company.all.collect { |c| c.postcode }, input_html: { class: 'chosen-select2' }
  filter :contact_name, as: :select, label: "Search by Contact Name", prompt: "Select or Type", collection: Company.all.collect { |c| c.postcode}, input_html: { class: 'chosen-select2' }
  filter :phone, as: :select, label: "Search by Phone Number", prompt: "Select or Type", collection: Company.all.collect { |c| c.phone }, input_html: { class: 'chosen-select2' }
  filter :email, as: :select, label: "Search by Email", prompt: "Select or Type", collection: Company.all.collect { |c| c.email }, input_html: { class: 'chosen-select2' }

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
