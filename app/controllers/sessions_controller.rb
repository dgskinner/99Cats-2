class SessionsController < ApplicationController
    before_action :require_loggedout, only: [:new, :create]  
  
    
  def new
    @user = User.new
  end
  
  def create
    user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )

    if user.nil?
      render json: "Credentials were wrong"
    else
      login!(user)
      flash[:welcome] = "Welcome back, #{user.user_name}!"
      redirect_to cats_url
    end
  end
  
  def destroy
    current_user.try(:reset_session_token!)
    session[:session_token] = nil
    redirect_to new_session_url
  end
end
