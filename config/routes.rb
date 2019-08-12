Rails.application.routes.draw do
  resources :clients
  devise_for :users, :controllers => { :sessions => "sessions" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"

  resources :lists
  #api
  mount ApplicationAPI => '/api'
  mount GrapeSwaggerRails::Engine => '/api_docs'

  #sidekiq
  require 'sidekiq/web'
  mount Sidekiq::Web, at: '/sidekiq'

  
  # resources :chat_rooms, only: [:new, :create, :show, :index]
  # root 'chat_rooms#index'

  # #cable
  # mount ActionCable.server => '/cable'

end
