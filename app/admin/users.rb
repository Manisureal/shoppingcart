ActiveAdmin.register User do
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
