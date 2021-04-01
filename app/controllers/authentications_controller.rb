class AuthenticationsController < ApplicationController
  skip_before_action :check_subscription!

  def index
    @authentications = Authentication.all
  end
end
