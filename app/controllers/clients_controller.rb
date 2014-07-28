class ClientsController < ApplicationController
  USER_NAME = ENV['AUTHENTICATE_USER_NAME']
  PASSWORD = ENV['AUTHENTICATE_PASSWORD']

# before_filter :authenticate_user!
# before_filter :authenticate_admin!
  before_action :authenticate

  def index
    @clients = Client.paginate(page: page)
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_param)

    if @client.save
      redirect_to clients_path, notice: t('client.message.create_success')
    else
      flash[:alert] = t('client.message.create_failed')
      render :new
    end
  end

  def edit
    @client = Client.find(client_id)
  end

  def update
    @client = Client.find(client_id)

    if @client.update(client_param)
      redirect_to clients_path, notice: t('client.message.update_success')
    else
      flash[:alert] = t('client.message.update_failed')
      render :edit
    end
  end

  def destroy
    @client = Client.find(client_id)
    if @client.destroy
      redirect_to clients_path, notice: t('client.message.delete_success')
    else
      redirect_to clients_path, alert: t('client.message.delete_failed')
    end
  end

  def show
    @client = Client.find(client_id)
  end

  protected
  def client_id
    params.require(:id)
  end

  def page
    params[:page]
  end

  def client_param
    params.require(:client).permit(:title, :first_name, :last_name, :email, :phone, :address, :company_name, :designation)
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
