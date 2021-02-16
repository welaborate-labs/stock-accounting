class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]

  def index
    @users = User.all
  end

  def update
    if @user.update(user_params)
      flash[:notice] = t('.notice')
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
    end
  end

  protected

    def set_user
      @user = User.find(current_user.id)
    end

    def user_params
      params.require(:user).permit(:name, :email, statement_files: [])
    end
end
