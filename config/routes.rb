Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root to: "pages#dashboard"
  resources :cars, only: [:index, :show, :new, :create, :edit, :update] do
    resources :plan_items do
      # get :generate_ics
    end
    resources :stops, only: [:index, :show, :new, :create, :edit, :update]
  end

  resources :stops do
    resources :item_by_stops
  end

  get "cars/:id/alerts", to: "plan_items#alerts"
  post "cars/:id/stops/new", to: "plan_items#get_item_for_creating_stop", as: :create_stop_from_alerts
  post "cars/:id", to: "plan_items#create_stop_from_plan"
  get "cars/:id/plan_items_gpt", to: "cars#call_maintenance", as: :call_maintenance

  get "/dashboard", to: "pages#dashboard"
end
