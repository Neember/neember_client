require 'rails_helper'

describe Api::ClientsController do

  describe 'get #index' do
    context 'show detail client' do
      before { create_list(:client, 3) }

      def do_request
        get :index, format: :json
      end

      # login to http basic auth
      include AuthHelper
      before(:each) do
        http_login
      end

      it 'fetches all clients and render index view' do
        ActionController::HttpAuthentication::Basic.encode_credentials(ENV['AUTHENTICATE_USER_NAME'], ENV['AUTHENTICATE_PASSWORD'])
        do_request

        expect(response).to render_template :index
        expect(assigns(:clients).size).to be == 3
      end
    end
  end

  describe 'get #show' do
    context 'show detail client' do
      let!(:client) { create :client }

      def do_request
        get :show, id: client.id, format: :json
      end

      # login to http basic auth
      include AuthHelper
      before(:each) do
        http_login
      end

      it 'render template show client detail and finds client' do
        ActionController::HttpAuthentication::Basic.encode_credentials(ENV['AUTHENTICATE_USER_NAME'], ENV['AUTHENTICATE_PASSWORD'])
        do_request

        expect(response).to render_template :show
        expect(assigns(:client)).to_not be_nil
      end
    end
  end
end
