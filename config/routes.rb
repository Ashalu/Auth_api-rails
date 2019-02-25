Rails.application.routes.draw do
	root 'welcome#index'
  devise_for :users do
    member do
      post :enable_multi_factor_authentication, to: 'user/multi_factor_authentication#verify_enable'
      post :disable_multi_factor_authentication, to: 'user/multi_factor_authentication#verify_disable'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'users/disable_otp_validate_auth'
  post 'users/enable_otp_validate_auth'
  get '/users/2fa' => 'users#update_two_fa', as: 'user_update_two_fa'
  
  resources :welcome
  namespace :api do
    namespace :v1 do
      resources :users
      resources :registrations, only: [:create] 
      resources :sessions, only: [:create, :destroy]
      post '/users/disable_otp_validate_auth'
      post '/users/enable_otp_validate_auth'
      post '/users/validate_otp'
      get '/users/me' => 'users#me'
      
      post '/users/disable_otp_validate_auth'
      post '/users/enable_otp_validate_auth'
      post '/users/otp_enabled'
    end

  end
end
