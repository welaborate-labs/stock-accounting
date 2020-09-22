class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  protect_from_forgery
  helper_method :current_user, :signed_in?

  protected

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  def current_user=(user)
    @current_user = user
  end
end
