class DashboardsController < ApplicationController
  before_action :authenticate_user!

  # def index
  #   @user = current_user
  #   if(@user.role == "tourist")
  #     @options = ["Bookings", "a", "b", "c"]
  #   elsif(@user.role == "guide")
  #     @options = ["Bus", "Schedule", "Bus stop"]
  #   elsif(@user.role == "admin")
  #     @options = ["Destinations", "Users"]
  #   end
  # end

  def index
    @user = current_user
    @options = dashboard_options(@user.role)
  end

  private

  def dashboard_options(role)
    case role
    when "tourist"
      [
        { name: "My Bookings", path: bookings_path }
      ]
    when "guide"
      [
        { name: "Buses", path: guide_buses_path },
        { name: "Schedules", path: guide_buses_path }, # can adjust later
      ]
    when "admin"
      [
        { name: "Destinations", path: admin_destinations_path },
        { name: "Users", path: "#" }
      ]
    else
      []
    end
  end
end
