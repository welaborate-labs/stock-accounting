 require 'rails_helper'

RSpec.describe "/statements", type: :request do
  let!(:statement_file) { create(:statement_file, :with_attachment) } 
  let!(:statement) { create(:statement, statement_file: statement_file) } 
  let!(:statement_2) { create(:statement, statement_file: statement_file) } 
  let(:create_statement) { build(:statement, statement_file: statement_file) }

  describe "GET #index" do
    before do
      get statements_url
    end
    
    it { is_expected.to render_template("index") }
    it { expect(assigns(:statements)).to eq([statement, statement_2]) } 
  end

  describe "GET #show" do
    before do
      get statement_url(statement)
    end

    it { expect(assigns(:statement)).to eq(statement) } 
    it { expect(response.body).to include statement.statement_date.to_s } 
    it { expect(response.body).to include statement.statement_file.id.to_s } 
  end

  describe "GET #new" do
    before do
      get new_statement_url
    end
    
    it { is_expected.to render_template("new") }
    it { expect(assigns(:statement)).to be_a_new(Statement) } 
  end

  describe "GET #edit" do
    before do
      get edit_statement_url(statement)
    end

    it { is_expected.to render_template("edit") } 
    it { expect(assigns(:statement)).to eq(statement) } 
  end

  describe "POST #create" do
    context "with valid parameters" do
      before do
        post statements_url, params: { statement: { statement_file_id: statement_file.id }}
      end
  
      it { 
        expect { 
          post statements_url, params: { statement: { statement_file_id: statement_file.id }}
        }.to change(Statement, :count).by(1) 
      }
  
      it { expect(flash['success']).to match("statement was successfully created.") } 
    end
    
    context "with invalid parameters" do
      before do
        post statements_url, params: { statement: { statement_file_id: nil }}
      end

      it { expect { subject }.not_to change(Statement, :count) } 
      it { expect(flash['errors']).to match("statement can't be blank.") }
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      before do
        patch statement_url(statement), params: { statement: { statement_date: "2020-09-24 11:57:19" }}
        statement.reload
      end

      it { expect(statement.statement_date).to eq("2020-09-24 11:57:19") } 
      it { expect(flash['success']).to match('Statement was successfully updated.') } 
      it { is_expected.to redirect_to statement_files_url }
    end
  end

  describe "DELETE #destroy" do
    before do
      delete statement_url(statement)
    end
    
    it { expect { delete statement_url(statement_2)}.to change(Statement, :count).by(-1) }
    it { is_expected.to redirect_to statements_url }
  end
end
