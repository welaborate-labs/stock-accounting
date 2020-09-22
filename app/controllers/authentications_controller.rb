class AuthenticationsController < ApplicationController
  def index
    @authentications = Authentication.all
  end
end
