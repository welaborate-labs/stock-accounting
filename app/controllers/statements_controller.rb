class StatementsController < ApplicationController
  before_action :set_statement, only: [:show, :edit, :update, :destroy]

  # GET /statements
  # GET /statements.json
  def index
    @statements = Statement.all
  end

  # GET /statements/1
  # GET /statements/1.json
  def show
  end

  # GET /statements/new
  def new
    @statement = Statement.new
  end

  # GET /statements/1/edit
  def edit
  end

  # POST /statements
  # POST /statements.json
  def create
    begin
    @statement = Statement.new(statement_params)

      if @statement.save
        flash['success']  = "statement was successfully created."
      else
        flash['errors'] = "statement can't be blank."
      end
    rescue ActionController::ParameterMissing => exception
      flash['errors'] = "statement can't be blank."
    end
  end

  # PATCH/PUT /statements/1
  # PATCH/PUT /statements/1.json
  def update
    if @statement.update(statement_params)
      flash['success']  = 'Statement was successfully updated.'
    else
      flash['errors'] = "#{@statement.errors}"
    end
    redirect_to statement_files_url
  end

  # DELETE /statements/1
  # DELETE /statements/1.json
  def destroy
    @statement.destroy
    respond_to do |format|
      format.html { redirect_to statements_url, notice: 'Statement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_statement
      @statement = Statement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def statement_params
      params.require(:statement).permit(:statement_date, :statement_file_id)
    end
end
