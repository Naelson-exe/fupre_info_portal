Rails.application.routes.draw do
  root "home#index"
  get "health", to: "health#show"

  get "/manifest.json", to: "pwa#manifest", defaults: { format: :json }

  # Public routes with custom paths
  resources :posts, only: [ :index, :show ], path: "memos"
  resources :events, only: [ :index, :show ], path: "calendar"
  get "about", to: "home#about"
  get "search", to: "search#index"

  # Admin namespace
  namespace :admin do
    get "login", to: "sessions#new", as: :login
    post "login", to: "sessions#create", as: :authenticate
    delete "logout", to: "sessions#destroy", as: :logout
    root "dashboard#index"
    get "analytics", to: "dashboard#analytics"

    resources :posts do
      collection do
        get :search
      end
    end

    resources :events do
      collection do
        get :search
      end
    end
  end

  if Rails.env.development? || Rails.env.test?
    get "up" => "rails/health#show", as: :rails_health_check
  end

  # Catches all other routes and redirects to the root path with a flash message
  match "*path", to: "application#not_found", via: :all
end
