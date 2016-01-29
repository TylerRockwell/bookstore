class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  

  def authenticate_user_or_admin
    unless current_user || current_admin
      redirect_to new_user_session_path, error: "You must be logged in to do that"
    end
  end
end
