class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :null_session, if: -> { request.format.json? }

  before_action :set_active_storage_current_host

  before_action :configure_permitted_parameters, if: :devise_controller?

   rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name phone role avatar])

    devise_parameter_sanitizer.permit(:account_update, keys: %i[name phone role avatar])
  end

  private

  def set_active_storage_current_host
    ActiveStorage::Current
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    
    respond_to do |format|
      format.html {redirect_to root_path}
      format.json {render json: {message: 'You are not authorized to perform this action'}, status: :unauthorized }
    end
  end
end
