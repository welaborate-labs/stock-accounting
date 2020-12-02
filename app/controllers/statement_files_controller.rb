class StatementFilesController < ApplicationController
  before_action :set_statement_file, only: [:destroy]

  def index
    @statement_files = StatementFile.all
  end

  def new
    @statement_file = StatementFile.new
  end

  def create
    begin
      @statement_file = current_user.accounts.find(choosen_account.id).statement_files.build(statement_file_params)

      if @statement_file.save
        redirect_to statement_files_path, notice: 'Statement file was successfully created.'
      else
        redirect_to statement_files_path, alert: 'Statement file was not created, please try again.'
      end
    rescue ActionController::ParameterMissing => exception
      redirect_to statement_files_path, alert: 'Statement File must be present.'
    end
  end

  def destroy
    if @statement_file.destroy
      redirect_to statement_files_path, notice: 'Statement file was successfully destroyed.'
    else
      redirect_to statement_files_path, alert: 'Statement file was not destroyed.'
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
