EvvntChallenge::Application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    resources :events, only: [:index] do
      get :search, on: :collection
    end

    resources :venues, only: :index do
      get :autocomplete, on: :collection
    end
  end

  root to: 'application#angular'
  # get "/*path" => "application#angular", format: :html
end
