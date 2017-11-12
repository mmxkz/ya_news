require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web, at: "/sidekiq"
  mount Crono::Web, at: "/crono"

  root "articles#index"

  namespace "admin" do
    root "articles#edit"
  end
end
