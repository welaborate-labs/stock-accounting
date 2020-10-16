class SessionsController < ApplicationController
  def new
  end

  def create
    @authentication = Authentication.find_or_create_from_hash(auth_hash)

    if signed_in?
      if @authentication
        flash[:notice] = 'Account successfully linked!'
      else
        flash[:notice] = 'Could not link this account!'
      end
    else
      if @authentication
        self.current_user = @authentication.user
        flash[:notice] = 'Signed in!'
      else
        flash[:notice] = 'Could not sign in or register account!'
      end
    end

    redirect_to user_path(current_user)
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
