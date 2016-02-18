class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def user_signed_in?
    session[:user_id].present?
  end
  helper_method :user_signed_in?
  # Definining a method inside the ApplicationController makes it available in
  # all controllers in our system. Adding `helper_method` :current_user` makes
  # this method available in all view files as well as a helper method.
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
  helper_method :current_user

  def sign_in(user)
    session[:user_id] = user.id
  end

  def authenticate_user
    # if session[:user_id] is nil we redirect to the sign in page
      redirect_to new_session_path, notice: "Please sign in!" unless user_signed_in?
    #end
  end


end