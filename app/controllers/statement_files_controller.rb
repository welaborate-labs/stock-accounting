class StatementFilesController < ApplicationController
  before_action :set_statement_file, only: [:show, :edit, :update, :destroy]

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
        flash['success']  = 'File attached successfully' 
      else
        flash['errors'] = "#{@statement_file.errors.full_messages.to_sentence}"
      end
    rescue ActionController::ParameterMissing => exception
      flash['errors'] = "The attachment can't be blank"
    end
    redirect_to statement_files_path 
  end

  # DELETE /statement_files/1
  # DELETE /statement_files/1.json
  def destroy
    if @statement_file.destroy
      flash['success'] = 'Statement file was successfully destroyed'
    else
      flash['errors'] = @statement_file.errors.full_messages.to_sentence
    end
    redirect_to statement_files_path 
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
