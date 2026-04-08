class AdminController < ApplicationController
  def users
    @users = User.all

    respond_to do |format|
      format.html
      format.json { render json: { users: @users }, status: :ok }
    end
  end

  def clone_destination
    destination = Destination.find_by(id: params[:id])
    new_destination = destination.amoeba_dup
    new_destination.save

    respond_to do |format|
      format.html
      format.json { render json: { clone_destination: new_destination }, status: :ok }
    end
  end
end
