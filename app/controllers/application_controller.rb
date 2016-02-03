class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_user_or_admin
    unless current_user || current_admin
      redirect_to new_user_session_path, error: "You must be logged in to do that"
    end
  end

  def after_sign_in_path_for(resource)
    if resource.class == Admin
      admin_dashboard_index_path
    else
      books_path
    end
  end

  def current_order
    if session[:order_id].nil?
      Order.new(user: current_user)
    else
      Order.find_by(id: session[:order_id])
    end
  end

  def cart
    current_user.cart || Cart.create(user: current_user)
  end
end
