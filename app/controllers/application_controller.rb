class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
  before_action :authenticate_admin!, if: :admins_url 
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :success, :info, :warning, :danger

  protected
  
  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Admin)
        admins_root_path
    else
        rooms_path
    end
  end
  
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :user
      root_path
    elsif resource_or_scope == :admin
      new_admin_session_path
    else
      root_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  
  def admins_url
    request.fullpath.include?("/admins")
  end
  
end
