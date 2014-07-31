class Api::ClientsController < ApplicationController
  USER_NAME = ENV['AUTHENTICATE_USER_NAME']
  PASSWORD = ENV['AUTHENTICATE_PASSWORD']

  before_action :authenticate

  def index
    @clients = Client.all
  end

  def show
    @client = Client.find(client_id)
  end

  protected
  def client_id
    params.require(:id)
  end

  def authenticate
    case request.format
    when Mime::JSON
      authenticate_or_request_with_http_basic do |user_name, password|
        user_name == USER_NAME && password == PASSWORD
      end
    end
  end
end
