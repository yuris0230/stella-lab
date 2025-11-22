Rails.application.routes.draw do
  # Top and About
  root to: "homes#top"
  get "about", to: "homes#about"

  # Devise
  devise_for :admins
  devise_for :users
  
  # CRUD
  resources :posts

  # My page + unsubscribe
  get "my_page", to: "users#show"
  delete "users/withdraw", to: "users#destroy", as: :users_withdraw
end