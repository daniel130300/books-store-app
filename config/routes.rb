Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :users
  resources :books, except: [:new, :create]
  get 'search_book', to: 'books#search'
  get 'serve_book_search', to: 'books#serve_search'
  get 'book_to_add/:id', to: 'books#book_to_add', as: "book_to_add"
  post 'add_book/:id', to: 'books#add_book', as: "add_book"
  get 'friends', to: 'users#friends'
  get 'search_friend', to: 'users#search'
  resources :friendships, only: [:create, :destroy]
  resources :users, only: [:show]
end
