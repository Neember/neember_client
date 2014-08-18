class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  validates :email, format: { :with => /\A([^@\s]+)@(futureworkz.com)\Z/i }

  def self.find_for_google_oauth2(access_token)
    data = access_token.info
    Admin.where(email: data['email']).first
  end
end
