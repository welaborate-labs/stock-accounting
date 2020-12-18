class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :failure]

  def new
  end

  def create
    @authentication = Authentication.find_or_create_from_hash(auth_hash)

    if signed_in?
      if @authentication
        flash[:notice] = 'Account successfully linked!'
      else
        redirect_to root_path, alert: 'Could not link this account!' and return
      end
    else
      if @authentication
        self.current_user = @authentication.user
        flash[:notice] = 'Signed in!'
      else
        redirect_to root_path, alert: 'Could not sign in or register account!' and return
      end
    end

    redirect_to statement_files_path
  end

  def destroy
    self.current_user = nil
    redirect_to root_url, notice: 'Signed out!'
  end

  def failure
    redirect_to root_url, alert: 'Sorry, we could not log you in!'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
