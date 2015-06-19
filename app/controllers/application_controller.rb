class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  
  protected
  
  def after_sign_in_path_for(user)
    user_path(user)
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, :picture, :picture_cache]
    devise_parameter_sanitizer.for(:account_update) << [:first_name, :last_name, :picture, :picture_cache, :bio, :redactor]
  end
  
end
