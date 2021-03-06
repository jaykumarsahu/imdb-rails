require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    namespace :v1 do
      resources :products, only: [:index]
      resources :movies, only: [:index, :create, :show]
      resources :sessions, only: [] do
        post :login, on: :collection
      end
      resources :registrations, only: [:create]
    end
  end

  root to: 'application#root'

end
