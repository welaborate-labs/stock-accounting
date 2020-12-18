require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe 'GET /' do
    subject { response }

    before do
      get '/'
    end

    it { is_expected.to have_http_status(:success) }
  end

  describe 'GET /auth/:provider/callback' do
    let(:http_request) { get '/auth/google/callback', params: params }
    let(:uid) { '123456789' }
    let(:name) { 'Paul Atreides' }
    let(:email) { 'muad.dib@dune.com' }
    let(:params) { { provider: :google, uid: uid } }

    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.add_mock(:google, { uid: uid, info: { name: name, email: email } } )
      Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
    end

    context 'user is not logged in' do
      context 'authentication and user does not exist' do
        describe 'request' do
          it { expect { http_request }.to change { User.where(email: email).count }.by(1) }
          it { expect { http_request }.to change { Authentication.where(uid: uid).count }.by(1) }
          it 'logs in the user' do
            expect_any_instance_of(ApplicationController).to receive(:current_user=).with(instance_of(User))

            http_request
          end
        end

        describe 'response' do
          subject { response }

          before do
            http_request
          end

          it { is_expected.to have_http_status :redirect }
          it { is_expected.to redirect_to statement_files_path }
          it 'sends Signed in! flash message' do
            expect(flash[:notice]).to eq 'Signed in!'
          end
        end
      end

      context 'user and authentication exists' do
        let(:user) { create(:user, email: email, name: name) }
        let!(:authentication) { create(:authentication, user: user, uid: uid) }

        describe 'request' do
          it { expect { http_request }.not_to change { User.count } }
          it { expect { http_request }.not_to change { Authentication.count } }
          it 'logs in the user' do
            expect_any_instance_of(ApplicationController).to receive(:current_user=).with(instance_of(User))

            http_request
          end
        end

        describe 'response' do
          subject { response }

          before do
            http_request
          end

          it { is_expected.to have_http_status :redirect }
          it { is_expected.to redirect_to statement_files_path }
          it 'sends Signed in! flash message' do
            expect(flash[:notice]).to eq 'Signed in!'
          end
        end
      end

      context 'user exists but authentication does not' do
        let(:user) { create(:user, email: email, name: name) }
        let!(:authentication) { create(:authentication, user: user, uid: '987654321') }

        describe 'request' do
          subject { http_request }

          it { expect { subject }.not_to change { User.count } }
          it { expect { subject }.to change { Authentication.where(user_id: user.id, uid: uid).count }.by(1) }
          it 'logs in the user' do
            expect_any_instance_of(ApplicationController).to receive(:current_user=).with(instance_of(User))

            http_request
          end
        end

        describe 'response' do
          subject { response }

          before do
            http_request
          end

          it { is_expected.to have_http_status :redirect }
          it { is_expected.to redirect_to statement_files_path }
          it 'sends Signed in! flash message' do
            expect(flash[:notice]).to eq 'Signed in!'
          end
        end
      end
    end

    context 'user is logged in' do
      let(:user) { create(:user, email: email, name: name) }

      before do
        allow_any_instance_of(ApplicationController).to receive(:current_user) { user }
      end

      context 'authentication exists' do
        let!(:authentication) { create(:authentication, user: user, uid: uid) }

        describe 'request' do
          it { expect { http_request }.not_to change { User.count } }
          it { expect { http_request }.not_to change { Authentication.count } }
        end

        describe 'response' do
          subject { response }

          before do
            http_request
          end

          it { is_expected.to have_http_status :redirect }
          it { is_expected.to redirect_to statement_files_path }
          it 'sends Account successfully linked! flash message' do
            expect(flash[:notice]).to eq 'Account successfully linked!'
          end
        end
      end

      context 'authentication does not exist' do
        let!(:authentication) { create(:authentication, user: user, uid: '987654321') }

        describe 'request' do
          it { expect { http_request }.not_to change { User.count } }
          it { expect { http_request }.to change { Authentication.where(user_id: user.id, uid: uid).count }.by(1) }
        end

        describe 'response' do
          subject { response }

          before do
            http_request
          end

          it { is_expected.to have_http_status :redirect }
          it { is_expected.to redirect_to statement_files_path }
          it 'sends Account successfully linked! flash message' do
            expect(flash[:notice]).to eq 'Account successfully linked!'
          end
        end
      end
    end
  end

  describe "GET /failure" do
    subject { response }

    before do
      get "/auth/failure"
    end

    it { is_expected.to have_http_status(:redirect) }
    it { is_expected.to redirect_to root_path }
    it 'sends alert flash message' do
      expect(flash[:alert]).to eq 'Sorry, we could not log you in!'
    end
  end

  describe "GET /logout" do
    let(:http_request) { get "/logout" }
    let(:user) { create(:user) }

    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user) { user }
    end

    describe 'request' do
      it 'logs out the user' do
        expect_any_instance_of(ApplicationController).to receive(:current_user=)

        http_request
      end
    end

    describe 'response' do
      subject { response }

      before do
        http_request
      end

      it { is_expected.to have_http_status(:redirect) }
      it { is_expected.to redirect_to root_path }
    end
  end
end
