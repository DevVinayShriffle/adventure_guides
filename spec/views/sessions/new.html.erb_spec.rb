require 'rails_helper'

RSpec.describe "users/sessions/new.html.erb", type: :view do
  before do
    @user = User.new
    
    # Define the Devise methods directly on the view object
    view.extend(Module.new do
      def resource
        @user
      end

      def resource_name
        :user
      end

      def devise_mapping
        Devise.mappings[:user]
      end

      def resource_class
        User
      end
    end)

    # Explicitly stub the path helper used in the form
    allow(view).to receive(:user_session_path).and_return('/users/sign_in')
    # Stub this too, as it is used for the "Forgot password" link in your HTML
    allow(view).to receive(:new_user_password_path).and_return('/users/password/new')
  end

  it 'renders login form' do
    render

    expect(rendered).to include("Login")
    expect(rendered).to have_selector("form[action='/users/sign_in']")
    expect(rendered).to have_field("user[email]")
    expect(rendered).to have_field("user[password]")
    
    # Ensure this matches the button text in your .erb (case-sensitive)
    expect(rendered).to have_button("Login")
    
  end
end
