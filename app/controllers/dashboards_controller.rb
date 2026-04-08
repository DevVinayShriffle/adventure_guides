class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @options = dashboard_options(@user.role)
  end

  private

  def dashboard_options(role)
    case role
    when "tourist"
      [
        { name: "My Bookings", path: bookings_path },
        { name: "Upcoming Bookings", path: upcoming_bookings_path },
        { name: "Cancelled Bookings", path: cancelled_bookings_path },
        { name: "My Profile", path: edit_user_registration_path }
      ]
    when "guide"
      [
        { name: "Buses", path: guide_buses_path },
        { name: "Schedules", path: guide_schedules_path },
        { name: "My Profile", path: edit_user_registration_path }
      ]
    when "admin"
      [
        { name: "Destinations", path: admin_destinations_path },
        { name: "Users", path: admin_users_path },
        { name: "My Profile", path: edit_user_registration_path }
      ]
    else
      []
    end
  end
end
