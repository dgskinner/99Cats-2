class UsersController < ApplicationController
  before_action :require_loggedout, only: [:new, :create]   
  
  def new  
  end
  
  def create
    fail
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      flash[:welcome] = "Welcome, #{@user.user_name}!"
      redirect_to user_cats_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
  
end
