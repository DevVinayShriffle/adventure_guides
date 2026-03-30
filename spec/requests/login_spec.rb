require 'rails_helper'

RSpec.describe 'Login', type: :request do
  let(:user) {create(:user)}

  it 'login user' do
    post "/login", params: {user: {email: user.email, password: user.password}}
    expect(response).to redirect_to(dashboard_path)

    follow_redirect!
    expect(response.body).to include('Logged in successfully.')
  end
end