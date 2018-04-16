class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order
  helper_method :reset_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery
  before_action :authenticate_user!

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:forname, :surname])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:forname, :surname])
  end


  def current_order
    if session[:order_id] && current_user
      Order.find(session[:order_id])
    else
      Order.new
    end
  end

  def reset_session
    @_request.reset_session
  end
end
