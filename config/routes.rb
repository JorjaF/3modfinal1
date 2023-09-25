Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :forecast, only: [:index, :show]
      resources :daily_weather, only: [:index, :show]

      get '/book-search', to: 'book_search#search'
    end
  end
end
