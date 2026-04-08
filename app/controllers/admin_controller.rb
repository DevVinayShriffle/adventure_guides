class AdminController < ApplicationController
  def users
    @users = User.all

    respond_to do |format|
      format.html
      format.json { render json: { users: @users }, status: :ok }
    end
  end
end
