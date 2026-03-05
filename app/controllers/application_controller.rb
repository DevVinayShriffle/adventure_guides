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

  private

  def set_active_storage_current_host
    ActiveStorage::Current
  end
end
