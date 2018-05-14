ActiveAdmin.register User, as: "Customer" do
  permit_params :forname, :surname, :email, :password, :password_confirmation, :admin, :company_id

  menu parent: "Users"

  controller do
    def scoped_collection
      # Without altering too much with the page and keep the context in its same format as active admin use the following:
      end_of_association_chain.where(admin: false)
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
      f.input :company
      f.input :email
      f.input :forname
      f.input :surname
      f.input :password
    end
    f.actions
  end

end
