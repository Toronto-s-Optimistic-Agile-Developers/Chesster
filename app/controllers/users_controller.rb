class UsersController < ApplicationController
before_action :authenticate_user!, only: [:new]
  
  def new
    @user = User.new
  end

  def create

  end

  def show

  end 

private

def user_params
  params.require(:user).permit(:name)

end
