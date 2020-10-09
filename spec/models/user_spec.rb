require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) } 
  let(:invalid_user) { build(:user, name: nil, email: nil) }
  let(:duplicate_user) { build(:user, email: user.email) }
  let(:name) { 'Paul Atreidez' }
  let(:email) { 'muad.di@dune.com' }
  let(:uid) { '123456789' }
  let(:hash) { { 'info' => { 'name' => name, 'email' => email }, 'provider' => 'identity', 'uid' => uid } }

  describe ".create_from_hash" do
    subject { User.create_from_hash(hash) }
    it { expect {subject}.to change{User.count}.by(1) }
  end

  describe "valid attributes" do
    subject { create(:user) } 
    it {is_expected.to be_valid}
  end

  describe "invalid attributes" do
    before do 
      invalid_user.save
      duplicate_user.save
    end

    it { is_expected.to be_invalid }

    context "name" do
      it { expect(invalid_user.errors[:name]).to include("can't be blank") }
    end

    context "email" do
      it { expect(invalid_user.errors[:email]).to include("can't be blank") }
      it { expect(duplicate_user.errors[:email]).to include("has already been taken") }
    end
  end

  describe "relationships" do
    context "authentications" do
      context "has many" do
        before do
          create(:authentication, uid: '123', provider: 'identity', user: user)
        end

        it { expect(user.authentications.count).to eq(1) }
      end
    end

    context "accounts" do
      before do
        FactoryBot.create_list(:account, 3, user: user)
      end

      context "has many" do
        it { expect(user.accounts.count).to eq(3) } 
      end

      context "dependent destroy" do
        it { expect {user.destroy}.to change{Account.count}.by(-3) }
      end
    end
  end
end
