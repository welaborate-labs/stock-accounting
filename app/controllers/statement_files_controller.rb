class StatementFilesController < ApplicationController
  before_action :set_statement_file,        only: [:destroy]
  before_action :check_choosen_account,     only: [:index, :create, :new]
  before_action :set_last_account,          only: [:index, :create, :new]
  

  def index
    @statement_files = StatementFile.all
  end

  def new
    @statement_file = StatementFile.new
  end

  def create
    begin
      @statement_file = choosen_account.statement_files.build(statement_file_params)

      if @statement_file.save
        redirect_to statement_files_path, notice: t('.notice')
      else
        redirect_to statement_files_path, alert: t('.alert')
      end
    rescue ActionController::ParameterMissing => exception
      redirect_to statement_files_path, alert: t('.alert')
    end
  end

  def destroy
    if @statement_file.destroy
      redirect_to statement_files_path, notice: t('.notice')
    else
      redirect_to statement_files_path, alert: t('.alert')
    end
  end

  private

  def set_statement_file
    @statement_file = StatementFile.find(params[:id])
  end

  def statement_file_params
    params.require(:statement_file).permit(:file)
  end
end
