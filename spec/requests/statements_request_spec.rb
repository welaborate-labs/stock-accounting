require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe "/statements", type: :request do
  let(:file) { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'modelo.pdf'), 'application/pdf') }
  let(:user) { create(:user) }
  let(:account) { create(:account, user: user) }
  let(:brokerage_account) { create(:brokerage_account, brokerage: 1, number: '123456-1', account: account) }
  let(:statement_file) { create(:statement_file, :with_file, account: account) }
  let!(:statement) { create(:statement, brokerage_account_id: brokerage_account.id, statement_file_id: nil) }
  let!(:statement2) { create(:statement, brokerage_account_id: brokerage_account.id, statement_file_id: nil) }
  let!(:trade) { create(:trade, statement: statement) }

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
    it { expect(response.body).to include statement.statement_date.to_date.to_s }
    it { expect(response.body).to include statement.number.to_s }
    describe "shows trade" do
      it { expect(assigns(:trades)).to include trade }
      it { expect(response.body).to include trade.ticker }
    end
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

    it "changes statements to 2" do
      expect(Statement.count).to eq(2)
    end

    describe "nested attributes" do
      subject { post statements_path, params: { statement: { statement_date: '01/01/01', number: '123456789', trades_attributes: [ ticker: '123', direction: 0, quantity: 12345, price: 54321 ]}}}

      it { expect { subject }.to change(Statement, :count).by(1) } 
      it { expect { subject }.to change(Trade, :count).by(1) } 
    end
  end

  describe "GET #edit" do
    before { get edit_statement_path(statement) }

    it { is_expected.to render_template("edit") } 
    it { expect(assigns(:statement)).to eq(statement) }
    describe "shows trade" do
      it { expect(assigns(:trades)).to include trade }
      it { expect(response.body).to include trade.ticker }
    end
  end

  describe "PATCH/PUT #update" do
    before do
      patch statement_path(statement), params: { statement: { number: '21213232', trades_attributes: [ ticker: '54321', id: trade.id] } }
      statement.reload
      trade.reload
    end

    describe "updates the statement" do
      it { expect(statement.number).to eq '21213232' }
    end

    describe "updates the trade" do
      it { expect(trade.ticker).to eq '54321' }
    end

    describe "deletes the trade" do
      subject { patch statement_path(statement), params: { statement: { trades_attributes: [ _destroy: 1, id: trade.id] } }}
      it { expect { subject }.to change(Trade, :count).by(-1) }
    end
  end
  
  describe "DELETE #destroy" do
    describe "deletes the statement and trades" do
      subject { delete statement_path(statement) }
      before { delete statement_path(statement2) }
      it { expect { subject }.to change(Statement, :count).by(-1) }
      it { expect { subject }.to change(Trade, :count).by(-1) }
      it { expect(flash[:notice]).to eq I18n.t('.statements.destroy.notice') }
      
    end
  end
end
