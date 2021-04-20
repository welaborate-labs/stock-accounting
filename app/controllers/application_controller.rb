class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!
  before_action :check_subscription!
  helper_method :current_user, :signed_in?, :choosen_account, :check_choosen_account, :set_last_account
  helper_method :check_subscription?
  include Pagy::Backend

  def plans_route
    redirect_to 'https://sandbox-app.vindi.com.br/customer/pages/390f8270-ec63-45a5-a359-373ef8886343/subscriptions/new'
  end
  
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

  def check_subscription!
    return if check_choosen_account
    redirect_to home_path unless check_subscription?
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
      flash[:alert] = "É necessário criar uma conta para prosseguir.
      #{view_context.link_to 'CLIQUE AQUI', new_account_path, 
      class: 'mdl-button mdl-js-button mdl-button--raised mdl-button--colored ma-10'} para criar uma conta."
    end
  end

  def set_last_account
    if !current_user.accounts.last.nil? && choosen_account.nil?
      choosen_account = current_user.accounts.last
      session[:choosen_account_id] = choosen_account.id
    end
  end

  def set_customer
    query = URI::encode("query=status=active AND email=#{current_user.email}")
    apikey ||= Base64.strict_encode64("#{ENV['VINDI_SANDBOX_KEY']}:")
    @customer = RestClient.get "#{api_endpoint}/customers?page=1&per_page=5&#{query}", 
    { Authorization: "Basic " + apikey }
  end
  
  def check_subscription?
    set_customer.include? 'id'
  end
  
  def payment_api
    @vindi_api ||= Vindi::Client.new(key: ENV['VINDI_SANDBOX_KEY'], api_endpoint: api_endpoint)
  end

  def api_endpoint
    @sandbox_endpoint ||= 'https://sandbox-app.vindi.com.br/api/v1/'
  end
end
