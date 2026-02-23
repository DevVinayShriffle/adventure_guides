require_dependency 'user_serializer'
class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def update
    if current_user.update!(update_params)
      respond_to do |format|
        format.html { redirect_to @user, notice: "User updated successfully." }
        format.json { render json: { user: UserSerializer.new(current_user), message: "User updated successfully." }, status: :ok }
      end
    end
  end

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
    if resource.persisted?
      @token = request.env['warden-jwt_auth.token']
      headers['Authorization'] = @token

      render json: {
        status: { code: 200, message: 'Signed up successfully.',
          token: @token,
          data: {user: UserSerializer.new(resource)} }
        }
    else
      render json: {
        status: { message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end

  def update_params
    params.require(:user).permit(:name, :phone, :password, :avatar)
  end
end