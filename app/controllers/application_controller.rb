class ApplicationController < ActionController::Base
  include ExceptionHandler
  protect_from_forgery with: :null_session, if: -> { request.format.json? }

  before_action :set_active_storage_current_host
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name phone role avatar])

    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone, :avatar])
  end
  
  def authenticate_user!(*args)
    if user_signed_in?
      super
    else
      flash[:notice] = "You need to login or sign up before continuing"
      
      render inline: "<script>setTimeout(function(){ Turbo.visit('#{new_user_session_path}') }, 3000);</script>", layout: true
    end
  end

  private

  def set_active_storage_current_host
    ActiveStorage::Current
  end

  def render_flash_stream
    respond_to do |format|
      format.turbo_stream { render "shared/_flash_stream" }
    end
  end
end
