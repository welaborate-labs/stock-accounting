 require 'rails_helper'

RSpec.describe "/statement_files", type: :request do
  let!(:statement_file) { create(:statement_file, :with_attachment) }
  let(:statement_file_2) { create(:statement_file, :with_attachment) }
  let(:file) { fixture_file_upload(Rails.root.join('spec/fixtures/files', 'modelo.pdf'), 'application/pdf') }

  describe "GET #index" do
    it "renders a successful response" do
      get statement_files_url
 
      expect(response).to render_template("index")
      expect(assigns(:statement_files)).to eq([statement_file])
    end
  end

  describe "GET #new" do
    it "renders a successful response" do
      get new_statement_file_url

      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new StatementFile and show flash message" do
        expect {
          post statement_files_url, params: { statement_file: { attach_file: file }}
        }.to change(StatementFile, :count).by(1)

        expect(flash['success']).to be_present
        expect(flash['success']).to match(/file attached successfully.*/)
      end

      it "creates a new attached file" do
        expect {
          post statement_files_url, params: { statement_file: { attach_file: file }}
        }.to change(ActiveStorage::Attachment, :count).by(1)
      end
    end

    context "with invalid parameters" do
      it "doesn't create a new StatementFile" do
        expect {
          post statement_files_url, params: { statement_file: nil }
        }.not_to change(StatementFile, :count)
      end
    end
  end

  describe "DELETE #destroy" do
    context "success" do
      it "destroys the requested statement_file" do
        expect {
          delete statement_file_url(statement_file)
        }.to change(StatementFile, :count).by(-1)
      end

      it "redirects to the statement_files (index)" do
        delete statement_file_url(statement_file)
        expect(response).to redirect_to(statement_files_url)
      end

      it "shows success flash message" do
        delete statement_file_url(statement_file)
        expect(flash['success']).to be_present
        expect(flash['success']).to match(/Statement file was successfully destroyed.*/)
      end
    end
  end
end
