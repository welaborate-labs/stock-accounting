class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!
  helper_method :current_user, :signed_in?

  protected

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  def current_user=(user)
    session[:user_id] = user&.id
    @current_user = user
  end

  def authenticate_user!
    redirect_to login_path unless signed_in?
  end
end
