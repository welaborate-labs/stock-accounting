require 'rails_helper'
RSpec::Mocks.configuration.allow_message_expectations_on_nil

RSpec.describe "Accounts", type: :request do
  let(:user) { create(:user, email: 'rspec@test.com') }
  let!(:account) { create(:account, user: user) }
  let(:acc_params) { { account: { 
    user: user,
    name: "MyFactoryName",
    document: "12345678910",
    address: "MyFactoryAddress MyFactoryAddress2",
    address_complement: "MyFactoryComplement",
    city: "MyFactoryCity",
    state: "MyFactoryState",
    country: "MyFactoryCountry",
    zipcode: "12345678",
    status: "Active" 
  }}}

  before { allow_any_instance_of(ApplicationController).to receive(:current_user) { user } }

  describe "GET #index" do
    context "when user loged in" do
      before { get accounts_path }

      it { is_expected.to render_template("index") }
      it { expect(assigns(:accounts)).to eq([account]) }
    end

    context "when user signed out" do
      before { expect_any_instance_of(ApplicationController).to receive(:current_user) {nil} }
      before { get accounts_path }
      
      it { is_expected.to redirect_to root_path }
    end

    context "when subscription is inactive" do
      before do 
        user.email = 'test@gmail.com'
        user.save!
        get accounts_path
      end
      
      it { is_expected.to redirect_to home_path }
    end
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

  describe "PUT #choose" do
    before { put account_choose_path, params: params }
    
    context "when params exists" do
      let(:params) { { choosen_account_id: account.id } }

      it { expect(flash[:notice]).to eq I18n.t('.accounts.choose.notice') } 
    end

    context "when params does not exist" do
      let(:params) { { choosen_account_id: nil } }

      it { expect(flash[:alert]).to eq I18n.t('.accounts.choose.alert') } 
    end
  end

  describe "POST #create" do
    context "valid attributes" do
      before { post accounts_path, params: acc_params }
      subject { post accounts_path, params: acc_params }

      it { expect {subject}.to change(Account, :count).by(1) }
      it { is_expected.to redirect_to accounts_path }
      it { expect(flash[:notice]).to eq I18n.t('.accounts.create.notice') }
    end

    context "invalid attributes" do
      before { post accounts_path, params: { account: { document: nil, name: nil }}}
      subject { post accounts_path, params: { account: { document: nil, name: nil }}} 

      it { expect(flash[:alert]).to eq("Nome não pode ficar em branco, Nome é muito curto (mínimo: 3 caracteres), Documento não pode ficar em branco, Documento não é válido e Documento é muito curto (mínimo: 11 caracteres)")}
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
      it { is_expected.to redirect_to accounts_path }
      it { expect(flash[:notice]).to eq I18n.t('.accounts.update.notice') }
    end

    describe "invalid attributes" do
      before do
        patch account_path(account), params: { account: { name: nil }}
        account.reload
      end

      it { expect(account.name).to eq('MyFactoryName') }
      it { expect(account.name).not_to eq(nil) }
      it { is_expected.to redirect_to edit_account_path }
      it { expect(flash[:alert]).to eq("Nome não pode ficar em branco e Nome é muito curto (mínimo: 3 caracteres)") }
    end
  end
end
