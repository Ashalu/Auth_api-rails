Rails.application.routes.draw do
	root 'welcome#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :welcome
  namespace :api do
    namespace :v1 do
      resources :users
      resources :sessions, only: [:create, :destroy]
    end

  end
end
