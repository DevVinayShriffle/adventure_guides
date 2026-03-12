class Users::PasswordsController < Devise::PasswordsController
  def new
    super
  end

  def create
    return if request.get?
    # super do |resource|
    #   if resource.errors.any?
    #     render :new
    #     return
    #   end

    #   respond_to do |format|
    #     format.html { redirect_to user_password_path, notice: "Reset password email sent successfully."}; return;
    #     format.json { message: "Reset password email sent successfully." }
    #   end
    # end
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      respond_to do |format|
        format.html { redirect_to user_password_path, notice: "Reset password email sent successfully." }
        format.json { render json: { message: "Reset password email sent successfully." }, status: :ok }
      end
    else
      # Handle errors
      respond_to do |format|
        format.html { render :new }
        format.json { render json: resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit

  end

  def update

  end
end