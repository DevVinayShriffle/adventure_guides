class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:create]
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :admin_only, only: [:index]

  def index
    @users = User.order(created_at: :desc)

    respond_to do |format|
      format.html
      format.json { render json: { users: @users }, status: :ok }
    end
  end

  # def create
  #   user = User.create!(user_params)

  #   respond_to do |format|
  #     format.html { redirect_to root_path, notice: "User registered successfully." }
  #     format.json { render json: { user: user, message: "User registered successfully." }, status: :created }
  #   end
  # end

  def show
    respond_to do |format|
      format.html
      format.json { render json: { user: @user }, status: :ok }
    end
  end

  # def update
  #   if current_user.update!(update_params)
  #     respond_to do |format|
  #       # format.html { redirect_to @user, notice: "User updated successfully." }
  #       format.json { render json: { user: current_user, message: "User updated successfully." }, status: :ok }
  #     end
  #   end
  # end

  # def destroy
  #   if @user.destroy
  #     respond_to do |format|
  #       format.html { redirect_to root_path, notice: "User deleted successfully." }
  #       format.json { render json: { message: "User deleted successfully." }, status: :ok }
  #     end
  #   end
  # end

  private

  # def user_params
  #   params.require(:user).permit(:name, :email, :password, :phone, :role)
  # end

  # def update_params
  #   params.require(:user).permit(:name, :phone, :password, :avatar)
  # end

  # def set_user
  #   @user = User.find(params[:id])

  #   unless @current_user.admin? || @current_user == @user
  #     render json: { message: "Unauthorized access." }, status: :unauthorized
  #   end
  # end

  def admin_only
    unless current_user.admin?
      render json: { message: "Admin access required." }, status: :unauthorized
    end
  end
end