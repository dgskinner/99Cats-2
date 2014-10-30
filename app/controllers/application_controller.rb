class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def login!(user)
      @current_user = user
      session[:session_token] = user.session_token
      Session.create(token: user.session_token, user_id: user.id)
  end
    
  def current_user
      # return nil if session[:session_token].nil?
      return nil if Session.find_by(token: session[:session_token]).nil?
      @current_user ||= User.find_by_session_token(session[:session_token])
  end

  helper_method :current_user
  
  def require_loggedout
    if signed_in?
      flash[:errors] = "Already signed in!"
      redirect_to user_cats_url(current_user)
    end
  end
  
  def signed_in?
    !!current_user
  end
  
  def require_loggedin
    unless signed_in?
      flash[:errors] ||= []
      flash[:errors] << "Must sign in first"
      redirect_to new_session_url
    end      
  end
  
end
