class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.find_for_google(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.google_data'] = request.env['omniauth.auth']
      User.create!(  name:     request.env['omniauth.auth'].info.name,
                    provider: request.env['omniauth.auth'].provider,
                    uid:      request.env['omniauth.auth'].uid,
                    token:    request.env['omniauth.auth'].credentials.token,
                    password: Devise.friendly_token[0, 20],
                    email:    request.env['omniauth.auth'].info.email
                  )
      redirect_to root_path
    end

    def failure
      redirect_to root_path
    end
  end
end