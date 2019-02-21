Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'omniauth_callbacks#google_oauth2'
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }
  root 'users#index'
    resources :users, only: [:index, :edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
