Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :one_day_forecast, only: [:index, :show]
      resources :five_day_forecast, only: [:index, :show]
      get '/munchies', to: 'munchies#index'
    end
  end
end
