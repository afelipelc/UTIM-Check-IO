class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

    #needed for cancan strong nested parameters
  # issue https://github.com/ryanb/cancan/issues/835#issuecomment-18663815
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

protected
  def configure_permitted_parameters
    params.permit(:login ,:username, :password)
    #para el inicio de sesion con username en /config/initializers/devices.rb
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :password, :remember_me) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :nombre, :role, :email, :password, :password_confirmation)}
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :nombre, :role, :email, :password, :password_confirmation, :current_password)}    
  end
end
