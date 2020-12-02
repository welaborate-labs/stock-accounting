class AccountsController < ApplicationController
  before_action :set_account, only: [:edit, :update, :show, :destroy]

  def new
    @account = Account.new
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

  private

  def set_account
    @account = Account.find(params[:id])
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
