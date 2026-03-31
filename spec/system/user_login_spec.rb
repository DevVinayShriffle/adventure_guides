# spec/system/user_login_spec.rb
# test real ui
require 'rails_helper'

RSpec.describe "User Login", type: :view do
  let(:user) {create(:user)}
  let(:wrong_password) { 'incorrect_password' }

  it "allow user to login with valid creadentials" do
    visit '/login'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Login'

    expect(page).to have_content("Logged in successfully.")
    expect(page).to have_current_path('/dashboard')
  end

  it "denies login with invalid credentials" do
    visit '/login'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'wrong_password'
    click_button 'Login'

    expect(page).to have_content("Invalid email or password")
    expect(page).to have_current_path('/login')
  end

  it "shows error on empty field", js: true do
    visit '/login'

    fill_in 'Email', with: ""
    fill_in 'Password', with: ""
    click_button 'Login'

    expect(page).to have_content("email can't be blank")
    expect(page).to have_content("password can't be blank")
    expect(page).to have_current_path('/login')
  end

  it "shows error on empty email field", js: true do
    visit '/login'

    fill_in 'Email', with: ""
    fill_in 'Password', with: user.password
    click_button 'Login'

    expect(page).to have_content("email can't be blank")
    expect(page).to have_current_path('/login')
  end

  it "shows error on empty password field", js: true do
    visit '/login'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: ""
    click_button 'Login'

    expect(page).to have_content("password can't be blank")
    expect(page).to have_current_path('/login')
  end
end