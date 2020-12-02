class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!
  before_action :set_choosen_account
  helper_method :current_user, :signed_in?, :choosen_account

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
    redirect_to root_path unless signed_in?
  end

  def choosen_account
    if session[:choosen_account_id]
      @choosen_account ||= current_user.accounts.find(session[:choosen_account_id])
    end
  end

  def set_choosen_account
    if params[:choosen_account_id]
      @choosen_account = current_user.accounts.find(params[:choosen_account_id])
      session[:choosen_account_id] = @choosen_account.id
    end
  end
end
