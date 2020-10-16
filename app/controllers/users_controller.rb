class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(current_user.id)
    
    if @user
      flash[:notice] = 'User found, probally a redirect here?'
    else
      flash[:alert] = 'User not found.'
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = 'Success, user updated.'
    else
      flash[:alert] = 'User not updated, please try again!'
    end
  end

  protected

  def user_params
    params.require(:user).permit(:name, :email, statement_files: [])
  end
end
