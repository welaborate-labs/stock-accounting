 require 'rails_helper'

RSpec.describe "/statement_files", type: :request do
  let(:file) { fixture_file_upload(Rails.root.join('spec/fixtures/files', 'modelo.pdf'), 'application/pdf') }

  describe 'GET #index' do
    subject { response }

    let!(:statement_file) { create(:statement_file, :with_file) }

    before do
      get statement_files_url
    end

    it { is_expected.to render_template('index') }

    it 'assigns statement_files' do
      expect(assigns(:statement_files)).to eq([statement_file])
    end
  end

  describe 'GET #new' do
    subject { response }

    before do
      get new_statement_file_url
    end

    it { is_expected.to render_template('new') }
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:http_request) { post statement_files_url, params: { statement_file: { file: file } } }

      describe 'request' do
        it { expect { http_request }.to change(StatementFile, :count).by(1) }
        it { expect { http_request }.to change(ActiveStorage::Attachment, :count).by(1) }
      end

      describe 'response' do
        subject { response }

        before do
          http_request
        end

        it { is_expected.to have_http_status :redirect }
        it { is_expected.to redirect_to statement_files_path }

        it 'sends flash message' do
          expect(flash[:notice]).to be_present
          expect(flash[:notice]).to eq('Statement file was successfully created.')
        end
      end
    end

    context 'with invalid parameters' do
      let(:http_request) { post statement_files_url, params: { statement_file: { file: nil } } }

      describe 'request' do
        it { expect { http_request }.not_to change(StatementFile, :count) }
        it { expect { http_request }.not_to change(ActiveStorage::Attachment, :count) }
      end

      describe 'response' do
        subject { response }

        before do
          http_request
        end

        it { is_expected.to have_http_status :redirect }
        it { is_expected.to redirect_to statement_files_path }

        it 'sends flash message' do
          expect(flash[:alert]).to be_present
          expect(flash[:alert]).to eq('Statement file was not created, please try again.')
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:statement_file) { create(:statement_file, :with_file) }
    let(:http_request) { delete statement_file_url(statement_file) }

    describe 'request' do
      it { expect { http_request }.to change(StatementFile, :count).by(-1) }
      it { expect { http_request }.to change(ActiveStorage::Attachment, :count).by(-1) }
    end

    describe 'response' do
      subject { response }

      before do
        http_request
      end

      it { is_expected.to have_http_status :redirect }
      it { is_expected.to redirect_to(statement_files_url) }

      it 'sends flash message' do
        expect(flash[:notice]).to be_present
        expect(flash[:notice]).to eq('Statement file was successfully destroyed.')
      end
    end
  end
end
