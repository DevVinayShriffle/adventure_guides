require 'rails_helper'

RSpec.describe "users/sessions/new.html.erb", type: :view do
  # before(:each) do
  #   @user = User.new
  #   view.controller.class.helper :all

  #   # Assign the required Devise instance variables directly
  #   assign(:resource, @user)
  #   assign(:resource_name, :user)
  #   assign(:devise_mapping, Devise.mappings[:user])

  #   allow(view).to receive(:new_user_session_path).and_return('/users/sign_in')
  # end

  it 'renders login form' do
    # assign(:user, User.new)
    # allow(view).to receive(:resource).and_return(User.new)
    # allow(view).to receive(:resource_name).and_return(:user)
    # allow(view).to receive(:devise_mapping).and_return(Devise.mappings[:user])

    render

    expect(rendered).to include("Login")
    # expect(rendered).to have_selector("form#login-form")
    expect(rendered).to have_selector("form[action='#{user_session_path}']")
    expect(rendered).to have_selector("input#email")
    expect(rendered).to have_selector("input#password")
    expect(rendered).to have_selector("button", text: "Login")
  end
end