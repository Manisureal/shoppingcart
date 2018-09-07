class PagesController < ApplicationController
  def home
    if current_user.admin?
      redirect_to admin_root_path
    elsif current_user.sales?
      redirect_to admin_sales_dashboard_path
    end
  end
end
