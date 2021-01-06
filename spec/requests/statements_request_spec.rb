require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe "/statements", type: :request do
  let(:file) { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'modelo.pdf'), 'application/pdf') }
  let(:user) { create(:user) }
  let(:account) { create(:account, user: user) }
  let(:brokerage_account) { create(:brokerage_account, account: account) } 
  let(:statement_file) { create(:statement_file, :with_file, account: account) }
  let!(:statement) { create(:statement, statement_file_id: statement_file.id, brokerage_account_id: brokerage_account.id) }
  let!(:statement2) { create(:statement, statement_file_id: statement_file.id, brokerage_account_id: brokerage_account.id) }

  before { allow_any_instance_of(ApplicationController).to receive(:current_user) { user } }
  before { allow_any_instance_of(ApplicationController).to receive(:choosen_account) { account } }

  describe "GET #index" do
    before { get statements_path }

    it { is_expected.to render_template("index") }
    it { expect(assigns(:statements)).to eq([statement, statement2]) } 
  end

  describe "GET #show" do
    before { get statement_path(statement) }

    it { expect(assigns(:statement)).to eq(statement) }
    it { expect(response.body).to include statement.statement_date.to_s } 
    it { expect(response.body).to include statement.statement_file.id.to_s } 
    it { expect(response.body).to include statement.brokerage_account.id.to_s } 
  end

  describe "GET #new" do
    before { get new_statement_path }

    it { is_expected.to render_template("new") }
    it { expect(assigns(:statement)).to be_a_new(Statement) } 
  end

  describe "POST #create" do
    subject { ProcessStatementFileJob.perform_later( statement_file.id ) } 
    it "enqueue the ProcessStatementFileJob" do
      expect { subject }.to have_enqueued_job.with( statement_file.id )
    end

    it "changes statements to 4" do
      expect(Statement.count).to eq(2)
    end
  end

  describe "GET #edit" do
    before { get edit_statement_path(statement) }

    it { is_expected.to render_template("edit") } 
    it { expect(assigns(:statement)).to eq(statement) }
  end

  describe "PATCH/PUT #update" do
    describe "valid attributes" do
      before { ProcessStatementFileJob.perform_now(statement_file_id: statement_file.id) }

      subject { response }

      # not implemented
      # need a file with 2 diferents numbers to start
      # and more 2 pages with the same number
      # it "updates the content" do
      #   expect(Statement.last.content).to match('=====PAGE=====')
      # end
    end
  end

  describe "DELETE #destroy" do
    subject { delete statement_path(statement2) }
    before { delete statement_path(statement) }

    it { expect { subject }.to change(Statement, :count).by(-1) }
    it { is_expected.to redirect_to(statements_path) }
    it { expect(flash[:notice]).to eq('Statement was successfully destroyed.') }
  end
end
