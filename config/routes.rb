Rails.application.routes.draw do
  get 'stops/index'
  get 'stops/show'
  get 'stops/new'
  get 'stops/create'
  get 'stops/edit'
  get 'stops/update'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :cars, only: [:index, :show, :new, :create, :edit, :update] do
    resources :plan_items
    resources :stops, only: [:index, :show, :new, :create, :edit, :update]
  end
end
