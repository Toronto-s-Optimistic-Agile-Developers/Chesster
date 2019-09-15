class UsersController < ApplicationController
before_action :authenticate_user!, only: [:new]
  
  def new
    @user = User.new
  end

  def create
    current_user.users.create(user_params)
    redirect_to root_path
  end

  def show
    @user = User.friendly.find(params[:id])
  end 

private

def user_params
  params.require(:user).permit(:name)

end
