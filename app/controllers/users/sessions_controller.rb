require_dependency 'user_serializer'
class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    self.resource = warden.authenticate(auth_options)

    if resource
      respond_with(resource)
    else
      self.resource = resource_class.new(sign_in_params)
      resource.errors.add(:base, "Invalid email or password")
      render :new, status: :unprocessable_entity
    end
  end

  private

  def respond_with(resource, _opt = {})
    return if request.get?
    @token = request.env['warden-jwt_auth.token']
    headers['Authorization'] = @token
    
    respond_to do |format|
      format.html { redirect_to dashboard_path, notice: 'User Logged in successfully.' }
      format.json { render json: {status: { code: 200, message: 'Logged in successfully.', token: "Bearer #{@token}", data: {user: UserSerializer.new(resource)} }}, status: :ok }
    end  
  end

  def respond_to_on_destroy(resource=nil)
    return if request.get?
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split.last,
       Rails.application.credentials.devise_jwt_secret_key!).first

      user_to_log_out = current_user || resource
    end

    # if user_to_log_out
    #   respond_to do |format|
    #     format.html { redirect_to user_session_path, notice: 'User Logged out successfully.' }
    #     format.json { render json: { status: 200, message: 'Logged out successfully.' }, status: :ok}
    #   end
    # else
    #   respond_to do |format|
    #     format.html { redirect_to user_session_path }
    #     format.json { render json: { status: 401, message: "Couldn't find an active session." }, status: :unauthorized }
    #   end
    # end

    respond_to do |format|
      format.html { redirect_to user_session_path, notice: 'User Logged out successfully.' }
      format.json do
        if user_to_log_out
          render json: { status: 200, message: 'Logged out successfully.' }, status: :ok
        else
          render json: { status: 401, message: "Couldn't find an active session." }, status: :unauthorized
        end
      end
    end
  end
end