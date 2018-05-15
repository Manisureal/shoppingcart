ActiveAdmin.register User, as: "Customer" do
  permit_params :forname, :surname, :email, :password, :password_confirmation, :admin, :company_id

  menu parent: "Users"
  # filter [:orders, :company, :audits, :email, :forname, :surname]
  remove_filter :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at,
                  :current_sign_in_at, :last_sign_in_at, :created_at, :updated_at, :admin

  # filter :email, as: 'chosen-select', collection: User.all, input_html: { class: 'chosen-select' }

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
    column :admin
    column :company
    actions
  end

  form do |f|
    f.inputs "Identity" do
      f.label :company, class: "f-label"
      f.select :company,
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

end
