require_dependency 'user_serializer'
class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def destroy
    if current_user.destroy
      respond_to do |format|
        format.html { redirect_to root_path, notice: "User deleted successfully." }
        format.json { render json: { message: "User deleted successfully." }, status: :ok }
      end
    end
  end

  private

  def respond_with(resource, _opts = {})
    return if request.get?
    if resource.persisted?
      @token = request.env['warden-jwt_auth.token']
      headers['Authorization'] = @token

      respond_to do |format|
        format.html { redirect_to dashboard_path, notice: 'User Registered successfully.' }
        format.json { render json: {status: { code: 200, message: 'Signed up successfully.', token: "Bearer #{@token}", data: {user: UserSerializer.new(resource)} }}, status: :ok }
      end
    else
      render json: {
        status: { message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end

  def update_resource(resource, params)
    if params[:password].blank? && params[:password_confirmation].blank?
      resource.update_without_password(params.except(:current_password, :password, :password_confirmation))
    else
      resource.update(params.except("current_password"))
    end
  end
end