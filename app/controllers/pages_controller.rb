class PagesController < ApplicationController
  def home
    case
      when current_user.admin?
        redirect_to admin_root_path
      when current_user.sales?
        redirect_to admin_sales_dashboard_path
      when current_user.sign_in_count == 1
        redirect_to edit_user_registration_path
      # else
      #   redirect_to root_path
    end
  end
end
