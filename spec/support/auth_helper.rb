module AuthHelper
  def http_login
    user = ENV['AUTHENTICATE_USER_NAME']
    pw = ENV['AUTHENTICATE_PASSWORD']
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end
end
