class LandingController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  skip_before_action :check_subscription!, only: [:index]

  layout "landing"

  def index
  end
end
