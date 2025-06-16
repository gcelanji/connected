class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    feed_path
  end

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_query

  def set_query
    @query = User.ransack(params[:q])
  end
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :birth_date])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :birth_date])
  end
end
