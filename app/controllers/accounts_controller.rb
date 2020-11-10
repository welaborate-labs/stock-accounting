class AccountsController < ApplicationController
  before_action :set_account, only: [:edit, :update, :show]

  def index
    @accounts = Account.all
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)
    @account.user_id = current_user.id

    if @account.save
      redirect_to new_account_path, notice: 'Account was successfully created.'
    else
      redirect_to new_account_path, alert: @account.errors.full_messages
    end
  end

  def update
    if @account.update(account_params)
      redirect_to new_account_path, notice: 'Account was successfully updated.'
    else
      redirect_to new_account_path, alert: @account.errors.full_messages
    end
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:user_id,
                                    :name,
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
