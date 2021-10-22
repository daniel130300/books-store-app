Rails.application.routes.draw do
  # root
  root 'welcome#index'
  #users and friends
  devise_for :users
  get 'search_friend', to: 'users#search_friend', as:"search_friend"
  get 'serve_search_friend', to: 'users#serve_search_friend', as: "serve_search_friend"
  get 'my_friends', to: 'users#my_friends', as: "my_friends"
  resources :friendships, only: [:create, :destroy]
  resources :users, only: [:show]
  #address
  resources :addresses, only: [:new, :create, :edit, :update]
  #books
  resources :books, except: [:new, :create]
  get 'search_book', to: 'books#search', as: "search_book"
  get 'serve_book_search', to: 'books#serve_search', as: "serve_book_search"
  get 'catalog_search', to: 'books#catalog_search', as: "catalog_search"
  get 'book_to_add/:id', to: 'books#book_to_add', as: "book_to_add"
  post 'add_book/:id', to: 'books#add_book', as: "add_book"
  #wishlist
  resources :wishlists, only: [:create, :destroy]
  get 'my_wishlist', to: 'users#my_wishlist', as: "my_wishlist"
end
