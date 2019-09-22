class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def authenticate
    redirect_to :login unless user_signed_in?
  end

  

  def user_signed_in?
    # converts current_user to a boolean by negating the negation
    !!current_user
  end

end