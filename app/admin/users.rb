ActiveAdmin.register User do
  permit_params :forname, :surname, :email, :password, :password_confirmation, :admin

  index do
    selectable_column
    column :id
    column :email
    column :forname
    column :surname
    column :created_at
    column :admin
    actions
  end
end
