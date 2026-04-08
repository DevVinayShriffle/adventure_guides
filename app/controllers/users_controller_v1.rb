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

  def show
    respond_to do |format|
      format.html
      format.json { render json: { user: @user }, status: :ok }
    end
  end

  private

  def admin_only
    unless current_user.admin?
      render json: { message: "Admin access required." }, status: :unauthorized
    end
  end
end