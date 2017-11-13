require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web, at: "/sidekiq"
  mount Crono::Web, at: "/crono"

  root "articles#actual"

  namespace "admin" do
    root "articles#new"
  end
end
