class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :failure]
  skip_before_action :check_subscription!, only: [:new, :create, :failure, :destroy]

  def new
  end

  def create
    @authentication = Authentication.find_or_create_from_hash(auth_hash)

    if signed_in?
      if @authentication
        
        flash[:notice] = t('.notice_link')
      else
        redirect_to root_path, alert: t('.alert_link') and return
      end
    else
      if @authentication
        self.current_user = @authentication.user
        flash[:notice] = t('.notice_signed')
      else
        redirect_to root_path, alert: t('.alert_signed') and return
      end
    end

    redirect_to home_path
  end

  def destroy
    self.current_user = nil
    redirect_to root_path
  end

  def failure
    redirect_to root_path, alert: t('.alert')
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
