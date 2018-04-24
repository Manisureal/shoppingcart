ActiveAdmin.register User do
  permit_params :forname, :surname, :email, :password, :password_confirmation, :admin, :company_id

  index do
    selectable_column
    column :id
    column :email
    column :forname
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
    f.inputs "Admin" do
      f.input :admin
    end
    f.actions
  end




end
