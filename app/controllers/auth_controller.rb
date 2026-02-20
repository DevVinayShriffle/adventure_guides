class AuthController < ApplicationController
  def login
  end

  def logout
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)  
  end
end
