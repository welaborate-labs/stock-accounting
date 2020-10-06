class StatementFilesController < ApplicationController
  # GET /statement_files
  # GET /statement_files.json
  def index
    @statement_files = StatementFile.all
  end

  def new
    @statement_file = StatementFile.new
  end
  
  # POST /statement_files
  # POST /statement_files.json
  def create
    begin
      @statement_file = StatementFile.new(statement_file_params)

      if @statement_file.save
        redirect_to statement_files_path, notice: 'Statement file was successfully created.'
      else
        redirect_to statement_files_path, alert: 'Statement file was not created, please try again.'
      end

    rescue ActionController::ParameterMissing => exception
      redirect_to statement_files_path, alert: 'Statement File must be present.'
    end
  end

  # DELETE /statement_files/1
  # DELETE /statement_files/1.json
  def destroy
    @statement_file = StatementFile.find(params[:id])

    @statement_file.destroy

    redirect_to statement_files_path, notice: 'Statement file was successfully destroyed.'
  end

  private
    # Only allow a list of trusted parameters through.
    def statement_file_params
      params.require(:statement_file).permit(:file)
    end
end
