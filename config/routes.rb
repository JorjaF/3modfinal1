Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :one_day_forecast, only: [:index, :show]
      resources :five_day_forecast, only: [:index, :show]
    end
  end
end
