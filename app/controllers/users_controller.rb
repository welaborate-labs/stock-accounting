class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    
    if @user
      flash[:notice] = 'User found, probally a redirect here?'
    else
      flash[:alert] = 'User not found.'
    end
  end

  def update
    @user = User.find(params[:id])

    @user.update!(params[:name])

    if @user.update!(params[:name])
      flash[:notice] = 'Success, user updated.'
    else
      flash[:alert] = 'User not updated, please try again!'
    end
  end

  protected

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
