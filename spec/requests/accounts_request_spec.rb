require 'rails_helper'

RSpec.describe "Accounts", type: :request do
  let(:user) { create(:user) }
  let(:account) { create(:account, user_id: user.id) }

  describe "GET #index" do
    before { get accounts_path }

    it { is_expected.to render_template("index") }
    it { expect(assigns(:accounts)).to eq([account]) }
  end

  describe "GET #show" do
    before { get account_path(account) }

    it { expect(assigns(:account)).to eq(account) } 
    it { expect(response.body).to include account.name.to_s } 
  end

  describe "GET #new" do
    before { get new_account_path }

    it { is_expected.to render_template("new") }
    it { expect(assigns(:account)).to be_a_new(Account) }
  end

  describe "GET #edit" do
    before { get edit_account_path(account) }

    it { is_expected.to render_template("edit") }
    it { expect(assigns(:account)).to eq(account) }
  end
  
  describe "POST #create" do
    context "valid attributes" do
      before { post accounts_path, params: { account: { user_id: user.id, document: 'abc', name: 'def' }}}
      subject { post accounts_path, params: { account: { user_id: user.id, document: 'abc', name: 'def' }}}

      it { expect {subject}.to change(Account, :count).by(1) }
      it { is_expected.to redirect_to new_account_path }
      it { expect(flash[:notice]).to eq("Account was successfully created.") }
    end

    context "invalid attributes" do
      before { post accounts_path, params: { account: { user_id: nil, document: nil, name: nil }}}
      subject { post accounts_path, params: { account: { user_id: nil, document: nil, name: nil }}} 

      it { expect(flash[:alert]).to eq(["User must exist", "User can't be blank", "Name can't be blank", "Document can't be blank"])}
      it { expect {subject}.not_to change(Account, :count) }
    end
  end

  describe "GET #update" do
    describe "valid attributes" do
      before do
        patch account_path(account), params: { account: { name: 'NameChanged' }}
        account.reload
      end

      it { expect(account.name).to eq('NameChanged') }
      it { is_expected.to redirect_to new_account_path }
      it { expect(flash[:notice]).to eq('Account was successfully updated.') }
    end

    describe "invalid attributes" do
      before do
        patch account_path(account), params: { account: { name: nil }}
        account.reload
      end

      it { expect(account.name).to eq('MyString') }
      it { expect(account.name).not_to eq(nil) }
      it { is_expected.to redirect_to new_account_path }
      it { expect(flash[:alert]).to eq(["Name can't be blank"]) }
    end
  end
end
