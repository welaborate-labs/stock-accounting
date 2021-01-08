class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!
  helper_method :current_user, :signed_in?, :choosen_account, :check_choosen_account, :set_last_account
  include Pagy::Backend
  
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
    begin
      if session[:choosen_account_id]
        @choosen_account ||= current_user.accounts.find(session[:choosen_account_id])
      end
    rescue ActiveRecord::RecordNotFound;end  
  end

  def check_choosen_account
    if @choosen_account.nil? && current_user.accounts.last.nil?
      redirect_back(fallback_location: home_path)
      flash[:alert] = "É necessário criar uma conta para prosseguir.#{view_context.link_to 'CLIQUE AQUI', new_account_path} para criar sua conta."
    end
  end

  def set_last_account
    if !current_user.accounts.last.nil? && choosen_account.nil?
      choosen_account = current_user.accounts.last
      session[:choosen_account_id] = choosen_account.id
    end
  end
end
