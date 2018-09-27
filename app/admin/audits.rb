ActiveAdmin.register Audit do
  # menu false
  menu if: proc{ current_user.admin? }
end
