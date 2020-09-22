class SessionsController < ApplicationController
  def new
  end

  def create
    auth = request.env['omniauth.auth']
    # Find an authentication here
    @authentication = Authentication.find_from_hash(auth)

    if @authentication.nil?
      # If no authentication was found, create a brand new one here
      @authentication = Authentication.create_from_hash(auth)
    end

    if signed_in?
      if @authentication.user == current_user
        # User is signed in so they are trying to link an authentication with their
        # account. But we found the authentication and the user associated with it 
        # is the current user. So the authentication is already associated with 
        # this user. So let's display an error message.
        flash[:notice] = 'Already linked that account!'
      else
        # The authentication is not associated with the current_user so lets 
        # associate the authentication
        @authentication.user = current_user
        @authentication.save
        flash[:notice] = 'Successfully linked that account!'
      end
    else
      if @authentication.user.present?
        # The authentication we found had a user associated with it so let's 
        # just log them in here
        self.current_user = @authentication.user
        flash[:notice] = 'Signed in!'
      else
        # No user associated with the authentication so we need to create a new one
        # Log him in or sign him up
        u = User.create_from_hash(auth)
        u.authentications << @authentication
        self.current_user = u
        flash[:notice] = 'Successfully created and linked that account!'
      end
    end
  end

  def destroy
    self.current_user = nil
    redirect_to root_url, notice: 'Signed out!'
  end

  def failure
    redirect_to root_url, alert: 'Sorry, something got wrong!'
  end
end
