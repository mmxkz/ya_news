require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web, at: "/sidekiq"
  mount Crono::Web, at: "/crono"

  root "articles#actual"

  get "/admin" => "articles#new"
  post "/admin", to: "articles#create"
  patch "/admin", to: "articles#create"
end
