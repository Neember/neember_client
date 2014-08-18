require 'rails_helper'

describe Admins::OmniauthCallbacksController do
  describe '#google_oauth2' do
    before do
      request.env['devise.mapping'] = Devise.mappings[:admin]
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    end

    def do_request
      post :google_oauth2
    end

    context 'User using futureworkz.com domain' do
      before { create :admin, email: 'martin@futureworkz.com' }
      it 'authenticates user' do
        expect { do_request }.to change(Admin, :count).by(0)
        expect(controller.admin_signed_in?).to be_truthy
      end
    end

    context 'User do not using futureworkz.com domain' do
      it 'authenticates user' do
        request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2].merge(info: {email: 'test@example.com'})

        expect { do_request }.to change(Admin, :count).by(0)
        expect(controller.admin_signed_in?).to be_falsey
      end
    end
  end
end
