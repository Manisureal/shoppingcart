ActiveAdmin.register User, as: "Customer" do
  permit_params :forname, :surname, :email, :password, :password_confirmation, :admin, :company_id

  menu parent: "Users", if: proc{ current_user.admin? }

  remove_filter :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at,
                  :current_sign_in_at, :last_sign_in_at, :created_at, :updated_at, :admin

  filter :forname_or_surname_or_email_or_company_name_cont, label: "Search Name/Company/Email", placeholder: "e.g. name, company, email..."

  # filter :company_id, as: :select, label: "Search by Company", prompt: "Select or Type", collection: Company.all.collect { |u| [u.name, u.id] },
  #        input_html: { class: 'chosen-select2' }
  # filter :email, as: :select, label: "Search by Email", prompt: "Select or Type", collection: User.all.collect { |u| [u.email] },
  #        input_html: { class: 'chosen-select2' }
  # filter :forname, as: :select, label: "Search by Forname", prompt: "Select or Type", collection: User.all.collect { |u| u.forname },
  #        input_html: { class: 'chosen-select2'}
  # filter :surname, as: :select, label: "Search by Surname", prompt: "Select or Type", collection: User.all.collect { |u| u.surname },
  #        input_html: { class: 'chosen-select2'}


  controller do
    def scoped_collection
      end_of_association_chain.where(admin: false)
      # Without altering too much with the page and keep the context in its same format as active admin use the following:
      # If we want to avoid showing non-admin caremeds users, then the following:
      # Company.includes(:users).where("name != ?", "Caremeds")
    end
  end

  index do
    selectable_column
    column :id
    column :email
    column :forname
    # do |company|
    #   company.contact_name.partition(" ").first
    # end
    column :surname
    column :created_at
    column "Last Signed", :last_sign_in_at
    column :admin
    column :company
    actions

  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Identity" do
      f.label :company, class: "f-label"
      f.select :company_id,
               Company.all.collect {|c| [ c.name, c.id ] },
               { include_blank: true},
               { multiple: false,
                 # id: "selecttwo",
                 class: "chosen-select",
                 data: {placeholder: "Some Pharmacy"}
               }
      f.input :email
      f.input :forname
      f.input :surname
      f.input :password
    end
    f.actions
  end

  action_item :view, only: :index, priority: 0 do
    link_to image_tag('search.png', height: 25), class: "search"
  end

end


