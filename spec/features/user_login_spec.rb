require 'rails_helper'

RSpec.feature "User Login validation", :js do
  scenerio 'User try to login with invalid credentials' do
    visit login_path

    # fill invalid data
    fill_in "Email", with: "invalid_email"
  end
end