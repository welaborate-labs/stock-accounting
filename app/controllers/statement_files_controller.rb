class StatementFilesController < ApplicationController
  before_action :set_statement_file, only: [:show, :edit, :update, :destroy]

  # GET /statement_files
  # GET /statement_files.json
  def index
    @statement_files = StatementFile.all
  end

  # POST /statement_files
  # POST /statement_files.json
  def create
    @statement_file = StatementFile.new(statement_file_params)

    if @statement_file.save!
      redirect_to statement_files_path 
      flash[:notice] = 'Statement file was successfully created.' 
    else
      redirect_to statement_files_path 
      flash[:notice] = "Statement file was not created, please try again."
    end
  end

  # DELETE /statement_files/1
  # DELETE /statement_files/1.json
  def destroy
    if @statement_file.destroy
      redirect_to statement_files_path 
      flash[:notice] = 'Statement file was successfully destroyed.'
    else
      redirect_to statement_files_path 
      flash[:notice] = 'Statement file was not destroyed, please try again.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_statement_file
      @statement_file = StatementFile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def statement_file_params
      params.require(:statement_file).permit(:processed_at, :attach_file)
    end
end
