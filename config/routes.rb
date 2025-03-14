Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root to: "pages#dashboard"
  resources :cars, only: [:index, :show, :new, :create, :edit, :update] do
    resources :plan_items
    resources :stops, only: [:index, :show, :new, :create, :edit, :update]
  end

  resources :stops do
    resources :item_by_stops
  end

  get "/dashboard", to: "pages#dashboard"
end
