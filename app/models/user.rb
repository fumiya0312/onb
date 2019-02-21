class User < ApplicationRecord
  extend Enumerize

  enumerize :role, in: { general: 1, admin: 99 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[google_oauth2]

  def self.find_for_google(auth)
    user = User.find_by(email: auth.info.email)

    unless user
      user = User.create( name:     auth.info.name,
                       provider: auth.provider,
                       uid:      auth.uid,
                       token:    auth.credentials.token,
                       password: Devise.friendly_token[0, 20],
                       email: auth.info.email
                     )
    end
    user
  end
end
