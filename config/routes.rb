Rails.application.routes.draw do
  devise_for :users
  root :to => 'homes#top'
  resources :books

  resources :tags do
    get 'books', to: 'books#search'
  end
end
