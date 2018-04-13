class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order
  helper_method :reset_session


  def current_order
    if session[:order_id]
      Order.find(session[:order_id])
    else
      Order.new
    end
  end

  def reset_session
    @_request.reset_session
  end
end
