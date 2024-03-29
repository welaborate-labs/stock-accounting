class StatementsController < ApplicationController
  before_action :set_statement,             only: [:edit, :update, :show, :destroy]
  before_action :check_choosen_account,     only: [:index, :create, :new]
  before_action :set_last_account,          only: [:index, :create, :new]

  def index
    @pagy, @statements = pagy(Statement.where(brokerage_account: choosen_account.brokerage_accounts), items: 10)
  end

  def show
  end

  def new
    @statement = Statement.new
  end

  def edit
  end

  def create
    begin
      @statement = choosen_account.brokerage_accounts.find_or_create_by(brokerage: 1, number: '123456-7').statements.build(statement_params)
            
      if @statement.save
        redirect_to statements_path, notice: t('.notice')
      else
        redirect_to new_statement_path, alert: @statement.errors.full_messages.to_sentence
      end
    rescue ActionController::ParameterMissing => exception
      redirect_to new_statement_path
    end
  end

  def update
    if @statement.update(statement_params)
      flash[:notice]  = t('.notice')
    else
      flash[:alert] = @statement.errors.full_messages.to_sentence
    end
    redirect_back(fallback_location: statements_path)
  end

  def destroy
    if @statement.destroy
      redirect_to statements_path, notice: t('.notice')
    else
      redirect_to statements_path, alert: t('.alert')
    end
  end

  private

    def set_statement
      @statement = Statement.find(params[:id])
      @pagy, @trades = pagy(Trade.where(statement_id: params[:id]), items: 10)
    end

    def statement_params
      params.require(:statement).permit(:content, :statement_date, :number, :ana_fee,
        :liquidation_fee, :registration_fee, :terms_fee, :exchange_fee, :operational_fee,
        :execution_fee, :custody_fee, :taxes, :capital_gain_tax, :other_fees,
        trades_attributes: [
          :id, :ticker, :direction, :status, :quantity, :price, :transacted_at, :_destroy
        ]
      )
    end
end
