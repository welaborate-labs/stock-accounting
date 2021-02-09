 require 'rails_helper'
 require 'sidekiq/testing'

RSpec.describe "/statement_files", type: :request do
  let(:file) { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'modelo.pdf'), 'application/pdf') }
  let(:user) { create(:user) } 
  let(:account) { create(:account, user: user) } 
  let!(:statement_file) { create(:statement_file, :with_file, account: account) }
  let!(:statement_file2) { create(:statement_file, :with_file, account: account) }

  before { allow_any_instance_of(ApplicationController).to receive(:current_user) { user } }
  before { allow_any_instance_of(ApplicationController).to receive(:choosen_account) { account } }

  describe 'GET #index' do
    subject { response }
    before { get statement_files_path }
    
    it { is_expected.to render_template('index') }
    it { expect(assigns(:statement_files)).to eq([statement_file, statement_file2]) }
  end

  describe 'GET #new' do
    before { get new_statement_file_path }

    it { expect(assigns(:statement_file)).to be_a_new(StatementFile) } 
    it { is_expected.to render_template('new') }
    it { expect(assigns(:statement_file)).to be_a_new(StatementFile) }
  end
  
  describe 'POST #create' do
    context 'valid parameters' do
      subject { post statement_files_path, params: { statement_file: { file: file, account_id: account.id }}}
      before { post statement_files_path, params: { statement_file: { file: file, account_id: account.id }}}

      it { expect { subject }.to change(StatementFile, :count).by(1) }
      it { expect { subject }.to change(ActiveStorage::Attachment, :count).by(1) }
      it { is_expected.to redirect_to statement_files_path }
      it { expect(flash[:notice]).to eq I18n.t('.statement_files.create.notice') }
    end

    context 'invalid parameters' do
      subject { post statement_files_path, params: { statement_file: { file: nil, account: nil }}}
      before { post statement_files_path, params: { statement_file: { file: nil, account: nil }}}
      
      it { expect { subject }.not_to change(StatementFile, :count) }
      it { expect { subject }.not_to change(ActiveStorage::Attachment, :count) }
      it { expect(flash[:alert]).to eq I18n.t('.statement_files.create.alert') }
      it { is_expected.to redirect_to statement_files_path }
    end
  end

  describe 'DELETE #destroy' do
    subject { delete statement_file_path(statement_file2) }
    before { delete statement_file_path(statement_file) }

    it { expect { subject }.to change(StatementFile, :count).by(-1) }
    it { expect { subject }.to change(ActiveStorage::Attachment, :count).by(-1) }
    it { is_expected.to redirect_to(statement_files_path) }
    it { expect(flash[:notice]).to eq I18n.t('.statement_files.destroy.notice') }
  end
end
