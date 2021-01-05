class StatementsController < ApplicationController
  before_action :set_statement, only: [:show, :edit, :update, :destroy]

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
      @statement = Statement.new(statement_params)

      if @statement.save
        flash[:notice]  = "Statement was successfully created."
      else
        flash[:alert] = @statement.errors.full_messages.to_sentence
      end
    rescue ActionController::ParameterMissing => exception
      flash[:alert] = "Statement can't be blank."
    end
  end

  def update
    if @statement.update(statement_params)
      flash[:notice]  = 'Statement was successfully updated.'
    else
      flash[:alert] = @statement.errors.full_messages.to_sentence
    end
    redirect_to statement_files_path
  end

  def destroy
    if @statement.destroy
      redirect_to statements_path, notice: 'Statement was successfully destroyed.'
    else
      redirect_to statements_path, alert: 'Statement was not destroyed.'
    end
  end

  private
  def set_statement
    @statement = Statement.find(params[:id])
  end

  def statement_params
    params.require(:statement).permit(:content)
  end
end
