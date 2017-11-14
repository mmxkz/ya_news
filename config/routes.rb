require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web, at: "/sidekiq"
  mount Crono::Web, at: "/crono"

  root to: "articles#index"

  namespace 'admin' do
    root to: "articles#new"
    post "/", to: "articles#update"
    patch "/", to: "articles#update"
  end
end
