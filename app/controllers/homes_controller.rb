class HomesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  skip_before_action :check_subscription!, only: [:index]

  def index
  end
end
