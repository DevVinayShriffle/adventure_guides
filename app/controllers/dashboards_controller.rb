class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    if(@user.role == "tourist")
      @options = ["Bookings", "a", "b", "c"]
    elsif(@user.role == "guide")
      @options = ["Bus", "Schedule", "Bus stop"]
    elsif(@user.role == "admin")
      @options = ["Destinations", "Users"]
    end
  end
end
