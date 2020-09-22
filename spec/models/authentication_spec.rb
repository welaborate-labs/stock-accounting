require 'rails_helper'

RSpec.describe Authentication, type: :model do
  let(:name) { 'Paul Atreides' }
  let(:email) { 'muad.div@dune.com' }
  let(:uid) { '123456789' }
  let(:provider) { 'google' }
  let(:hash) { { 'info' => { 'name' => name, 'email' => email }, 'provider' => provider, 'uid' => uid } }

  describe '.find_from_hash' do
    subject { Authentication.find_from_hash(hash) }

    context 'authentication exists' do
      let!(:authentication) { create(:authentication, uid: uid, provider: provider) }

      it { is_expected.to eq authentication }
    end

    context 'authentication does not exist' do
      it { is_expected.to be_nil }
    end
  end

  describe '.create_from_hash' do
    subject { Authentication.create_from_hash(hash) }

    context 'user exists' do
      let!(:user) { create(:user, name: name, email: email) }

      it { expect { subject }.to change { Authentication.count }.from(0).to(1) }
      it { expect { subject }.not_to change { User.count } }
      it { is_expected.to be_a Authentication }

      describe 'associates existing user' do
        subject { Authentication.create_from_hash(hash).user }

        it { is_expected.to eq user }
      end
    end

    context 'user does not exist' do
      it { expect { subject }.to change { Authentication.count }.from(0).to(1) }
      it { expect { subject }.to change { User.count }.from(0).to(1) }
      it { is_expected.to be_a Authentication }

      describe 'creates user with email from hash' do
        subject { Authentication.create_from_hash(hash).user.email }

        it { is_expected.to eq email }
      end
    end
  end
end
