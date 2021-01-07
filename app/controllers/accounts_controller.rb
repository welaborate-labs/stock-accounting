class AccountsController < ApplicationController
  before_action :set_account,           only: [:edit, :update, :show, :destroy]
  before_action :set_choosen_account,   only: [:choose]

  def index
    @accounts = current_user.accounts
  end

  def new
    @account = current_user.accounts.build
  end

  def create
    @account = current_user.accounts.build(account_params)

    if @account.save
      redirect_to accounts_path, notice: 'Account was successfully created.'
    else
      redirect_to accounts_path, alert: @account.errors.full_messages
    end
  end

  def update
    if @account.update(account_params)
      redirect_to accounts_path, notice: 'Account was successfully updated.'
    else
      redirect_to accounts_path, alert: @account.errors.full_messages
    end
  end

  def destroy
    if @account.destroy
      redirect_to accounts_path, notice: 'Account was successfully deleted.'
    else
      redirect_to accounts_path, notice: 'Account was not updated.'
    end
  end

  def choose
    if set_choosen_account
      flash[:notice] = 'Selected Account was successfully changed.'
    else
      flash[:notice] = 'Selected Account was not changed.'
    end
    redirect_back(fallback_location: home_path)
  end

  private

  def set_account
    @account = current_user.accounts.find(params[:id])
  end

  def set_choosen_account
    if params[:choosen_account_id].present?
      choosen_account = current_user.accounts.find(params[:choosen_account_id])
      session[:choosen_account_id] = choosen_account.id
    end
  end

  def account_params
    params.require(:account).permit(:name,
                                    :document,
                                    :address,
                                    :address_complement,
                                    :city,
                                    :state,
                                    :country,
                                    :zipcode,
                                    :phone_personal,
                                    :phone_business,
                                    :phone_mobile,
                                    :status)
  end
end
