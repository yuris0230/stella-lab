Rails.application.routes.draw do
  # Top and About (public pages)
  root to: "homes#top"
  get "about", to: "homes#about"

  # Devise authentication for admins and users
  devise_for :admins
  devise_for :users

  # Main browsable game data
  resources :characters, only: [:index, :show] do
    resources :topics, only: [:new, :create]
  end

  resources :items, only: [:index, :show] do
    resources :topics, only: [:new, :create]
  end

  resources :guides, only: [:index, :show]
  resources :tier_lists, only: [:index, :show]

  # Community content
  resources :topics, only: [:index, :show] do
    resources :posts, only: [:create]
  end
  get "latest_posts", to: "posts#latest", as: :latest_posts

  # Member directory (user side)
  get "members",     to: "members#index", as: :members
  get "members/:id", to: "members#show",  as: :member

  # My Page + profile + unsubscribe
  get "my_page", to: "users#show"
  resource :profile, only: [:edit, :update], controller: "user_profiles"
  delete "users/withdraw", to: "users#destroy", as: :users_withdraw

  # Favorites / likes
  get "favorites", to: "favorites#index", as: :favorites

  # ====== ADMIN ======
  namespace :admin do
    root to: "dashboard#index"

    # Home / About content editors
    resource :home, only: [:edit, :update], controller: "home"
    resource :about, only: [:edit, :update], controller: "about"

    # Admin member management
    resources :members, only: [:index, :show, :edit, :update]

    # Characters & items
    resources :characters
    resources :items


    # Tier lists + entries (NESTED)
    resources :tier_lists do
      resources :tier_list_entries, only: [:index, :new, :create, :edit, :update, :destroy]
    end

    # Guides management
    resources :guides
  end
end