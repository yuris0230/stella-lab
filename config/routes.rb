Rails.application.routes.draw do
  # Top and About (public pages)
  root to: "homes#top"
  get "about", to: "homes#about"

  # Devise authentication for admins and users
  devise_for :admins
  devise_for :users

  # Main browsable game data
  # These will provide characters_path, items_path, guides_path, tier_lists_path
  resources :characters, only: [:index, :show]
  resources :items, only: [:index, :show]
  resources :guides, only: [:index, :show]
  resources :tier_lists, only: [:index, :show]

  # Community content
  # topics_path, topic_path
  resources :topics, only: [:index, :show, :new, :create] do
    resources :posts, only: [:create]
  end
  get 'latest_posts', to: 'posts#latest', as: :latest_posts

  # Member directory (user side)
  # members_path, member_path
  get "members",     to: "members#index", as: :members
  get "members/:id", to: "members#show",  as: :member

  # My Page + unsubscribe (user account pages)
  # my_page_path already used in navbar/sidebar
  get "my_page", to: "users#show"
  delete "users/withdraw", to: "users#destroy", as: :users_withdraw

  # Favorites / likes index (for sidebar "Favorites")
  # favorites_path
  get "favorites", to: "favorites#index", as: :favorites
end