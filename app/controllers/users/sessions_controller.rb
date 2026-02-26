require_dependency 'user_serializer'
class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opt = {})
    @token = request.env['warden-jwt_auth.token']
    headers['Authorization'] = @token
    
    render json: {
      status: {
        code: 200, message: 'Logged in successfully.',
        token: @token,
        data: {
          user: UserSerializer.new(current_user)
        }
      }
    }, status: :ok
  end

  def respond_to_on_destroy(resource=nil)
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split.last,
       Rails.application.credentials.devise_jwt_secret_key!).first

      # current_user = User.find(jwt_payload['sub'])
       user_to_log_out = current_user || resource
    end

    if user_to_log_out
      render json: {
        status: 200,
        message: 'Logged out successfully.'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end

  def after_sign_in_path_for(resource)
    request.params[:return_to] || root_path
  end
end