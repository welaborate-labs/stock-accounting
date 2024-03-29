class IdentitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @identity = request.env['omniauth.identity']
  end
end
