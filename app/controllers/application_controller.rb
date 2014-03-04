class ApplicationController < ActionController::Base
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :update_sanitized_params, if: :devise_controller?
  before_filter :set_return_path 

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation, :first_name, :last_name)}
  end
  
  def after_sign_in_path_for(user)
    session["user_return_to"] || account_path 
  end

  def set_return_path
    unless devise_controller? || request.xhr? || !request.get?
      session["user_return_to"] = request.url
    end
  end
end