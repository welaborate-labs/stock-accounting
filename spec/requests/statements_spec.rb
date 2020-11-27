require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe "/statements", type: :request do
  let(:user) { create(:user) }
  let(:account) { create(:account, user_id: user.id) }
  let(:brokerage_account) { create(:brokerage_account, account_id: account.id) } 
  let(:statement_file) { create(:statement_file, :with_file, account_id: account.id) }
  let!(:statement) { create(:statement, statement_file_id: statement_file.id, brokerage_account_id: brokerage_account.id) }
  let!(:statement2) { create(:statement, statement_file_id: statement_file.id, brokerage_account_id: brokerage_account.id) }

  describe "GET #index" do
    before do
      get statements_path
    end
    
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

  describe "GET #edit" do
    before { get edit_statement_path(statement) }

    it { is_expected.to render_template("edit") } 
    it { expect(assigns(:statement)).to eq(statement) } 
  end

  describe "POST #create" do
    context "with valid parameters" do
      before { post statements_path, params: { statement: { statement_file_id: statement_file.id, brokerage_account_id: brokerage_account.id }}}
      subject { post statements_path, params: { statement: { statement_file_id: statement_file.id, brokerage_account_id: brokerage_account.id }}}

      it { expect { subject }.to change(Statement, :count).by(1) }
      it { expect(flash[:notice]).to eq("Statement was successfully created.") } 
    end
    
    context "with invalid parameters" do
      before do
        post statements_path, params: { statement: { statement_file_id: nil }}
      end

      it { expect { subject }.not_to change(Statement, :count) } 
      it { expect(flash[:alert]).to eq("[\"Statement file must exist\", \"Brokerage account must exist\"]") }
    end

  describe "PATCH/PUT #update" do
    describe "valid attributes" do
      before do
        patch statement_path(statement), params: { statement: { statement_date: '2020-10-26 11:00:00' }}
        statement.reload
      end

      it { expect(statement.statement_date).to eq('2020-10-26 11:00:00') }
      it { is_expected.to redirect_to statement_files_path }
      it { expect(flash[:notice]).to eq('Statement was successfully updated.') }
    end

    describe "invalid attributes" do
      before do
        patch statement_path(statement), params: { statement: { statement_file_id: nil }}
        statement.reload
      end

      it { is_expected.to redirect_to statement_files_path }
      it { expect(flash[:alert]).to eq("[\"Statement file must exist\"]") }
    end

  describe "DELETE #destroy" do
    subject { delete statement_path(statement2) }
    before { delete statement_path(statement) }
    
    it { expect { subject }.to change(Statement, :count).by(-1) }
    it { is_expected.to redirect_to(statements_path) }
    it { expect(flash[:notice]).to eq('Statement was successfully destroyed.') }
  end
end
