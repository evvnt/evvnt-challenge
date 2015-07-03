EvvntChallenge::Application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root to: 'application#angular'

  namespace :api, defaults: {format: :json} do
    resources :events, only: [:index] do
      get :search, on: :collection
    end
  end
end
