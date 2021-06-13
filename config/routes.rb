Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get '/anime', to: 'anime#index'
      get 'anime/search', to: 'anime#search'
      get '/anime/:id', to: 'anime#show'
      delete '/anime/:id', to: 'anime#delete'

      get '/searches', to: 'searched#index'
      get 'searches/:id', to: 'searched#show'
      delete '/searches/:id', to: 'searched#delete'
    end
  end
end
