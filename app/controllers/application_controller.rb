class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def login!(user)
      @current_user = user
      session[:session_token] = user.session_token
  end
    
  def current_user
      return nil if session[:session_token].nil?
      @current_user ||= User.find_by_session_token(session[:session_token])
  end

  helper_method :current_user
  
  def require_loggedout
    if current_user
      flash[:errors] = "Already signed in!"
      redirect_to cats_url
    end
  end
end