class AccountsController < ApplicationController
  before_action :set_account,           only: [:edit, :update, :show, :destroy]
  before_action :set_choosen_account,   only: [:choose]
  after_action  :set_last_account,      only: [:create, :destroy]

  def index
    @accounts = current_user.accounts
  end

  def new
    @account = current_user.accounts.build
  end

  def create
    @account = current_user.accounts.build(account_params)

    if @account.save
      redirect_to accounts_path, notice: t('.notice')
    else
      redirect_to new_account_path, alert: @account.errors.full_messages.to_sentence
    end
  end

  def update
    if @account.update(account_params)
      redirect_to accounts_path, notice: t('.notice')
    else
      redirect_to edit_account_path(@account), alert: @account.errors.full_messages.to_sentence
    end
  end

  def destroy
    if @account.destroy
      redirect_to accounts_path, notice: t('.notice')
    else
      redirect_to accounts_path, alert: t('.alert')
    end
  end

  def choose
    if set_choosen_account
      flash[:notice] = t('.notice')
    else
      flash[:alert] = t('.alert')
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
