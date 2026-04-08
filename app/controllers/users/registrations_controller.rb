require_dependency 'user_serializer'
class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json, :html, :turbo_stream

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
    # byebug
    return if (resource.errors.any? && action_name == "update")
    if resource.persisted?
      @token = request.env['warden-jwt_auth.token']
      headers['Authorization'] = @token
      
      # if resource[:updated_at] == Time.now
      respond_to do |format|

        # SIGNUP → REDIRECT
        if action_name == "create"
          flash[:notice] = "User Registered successfully."
          format.html { redirect_to dashboard_path }
          format.turbo_stream { redirect_to dashboard_path }
        end

        # UPDATE → TURBO STREAM
        if action_name == "update"
          flash.now[:notice] = "Profile updated successfully."
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.replace(
                "sidebar_avatar",
                partial: "dashboards/sidebar_avatar",
                locals: { user: current_user }
              ),
              turbo_stream.replace("flash-messages", partial: "shared/flash_messages"),
              turbo_stream.update(
                "dashboard_content",
                render_to_string(
                  inline: %{
                    <h2 class="text-2xl font-semibold text-gray-600">
                      Welcome #{current_user.name}
                    </h2>
                    <p class="mt-2 text-gray-500">
                      Profile updated successfully.
                    </p>
                  }
                )
              )
            ]
          end

          format.html { redirect_to dashboard_path }
        end

        format.json do
          render json: {
            status: {
              code: 200,
              message: "Success",
              token: "Bearer #{@token}",
              data: { user: UserSerializer.new(resource) }
            }
          }
        end
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  # def update_resource(resource, params)
  #   if params[:password].blank? && params[:password_confirmation].blank?
  #     resource.update_without_password(params.except(:current_password, :password, :password_confirmation))
  #   else
  #     resource.update(params.except("current_password"))
  #   end
  # end

  def update_resource(resource, params)
    # byebug
    if params[:password].present?
      unless resource.valid_password?(params[:current_password])
        resource.errors.add(:current_password, "is incorrect")
        render :edit
        return
      end
    end

    if params[:password].blank? && params[:password_confirmation].blank?
      resource.update_without_password(params.except(:current_password))
    else
      resource.update(params.except(:current_password))
    end
  end

  def sign_up_params
    params.require(:user).permit(:name, :email, :phone, :avatar, :role, :password, :password_confirmation)
  end
end