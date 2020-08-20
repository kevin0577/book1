Rails.application.routes.draw do
  get 'home/top'
  get 'home/about'
  devise_for :users
  root "home#top"
  get "home/about"
  resources :users
  resources :books
end
