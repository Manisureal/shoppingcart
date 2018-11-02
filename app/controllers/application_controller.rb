class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order
  helper_method :reset_session
  before_action :configure_permitted_parameters, if: :devise_controller?

  #Devise
  protect_from_forgery
  #If the user is coming from an external link, take them to the link after authenticating/logging in
  before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user!

  #Pundit
  include Pundit
  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:forname, :surname, :company])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:forname, :surname])
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || super
    # case
    #   when current_user.admin?
    #     admin_root_path
    #   when current_user.sales?
    #     admin_sales_dashboard_path
    #   when current_user.sign_in_count == 1
    #     edit_user_registration_path
    #   else
    #     root_path
    # end
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

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  # The below two methods are to help a user to redirect back to the external link after logging in
  # Its important that the location is NOT stored if:
    # - The request method is not GET (non idempotent)
    # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an
    #    infinite redirect loop.
    # - The request is an Ajax request as this can lead to very unexpected behaviour.
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end

end
