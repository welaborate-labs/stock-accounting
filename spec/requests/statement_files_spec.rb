 require 'rails_helper'

RSpec.describe "/statement_files", type: :request do
  let!(:statement_file) { create(:statement_file, :with_attachment) }
  let!(:statement_file2) { create(:statement_file, :with_attachment) }
  let(:file) { fixture_file_upload(Rails.root.join('spec/fixtures/files', 'modelo.pdf'), 'application/pdf') }

  describe "GET #index" do
    before do
      get statement_files_url
    end
    
    it { is_expected.to render_template("index") }
    it { expect(assigns(:statement_files)).to eq([statement_file, statement_file2]) } 
  end

  describe "GET #new" do
    before do
      get new_statement_file_url
    end

    it { is_expected.to render_template("new") }
    it { expect(assigns(:statement_file)).to be_a_new(StatementFile) } 
  end

  describe "POST #create" do
    context "with valid parameters" do
      before do
        post statement_files_url, params: { statement_file: { attach_file: file }}
      end
      
      it { expect { post statement_files_url, params: { statement_file: { attach_file: file }}
        }.to change(StatementFile, :count).by(1)}
      it { expect { post statement_files_url, params: { statement_file: { attach_file: file }}
        }.to change(ActiveStorage::Attachment, :count).by(1)}
      it { expect(flash['success']).to match("File attached successfully") } 
      it { is_expected.to redirect_to statement_files_path }
    end

    context "with invalid parameters" do
      before do
        post statement_files_url, params: { statement_file: { attach_file: nil }}
      end

      it { expect { post statement_files_url, params: { statement_file: nil }
        }.not_to change(StatementFile, :count)}
      it { expect(flash['errors']).to match("Attach file can't be blank") }
      it { is_expected.to redirect_to statement_files_path }
    end
  end

  describe "DELETE #destroy" do
    before do
      delete statement_file_url statement_file
    end
    
    it { expect { delete statement_file_url statement_file2
      }.to change(StatementFile, :count).by(-1)}
    it { is_expected.to redirect_to statement_files_path } 
    it { expect(flash['success']).to match("Statement file was successfully destroyed") } 
  end
end
