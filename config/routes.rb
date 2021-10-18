Rails.application.routes.draw do
  devise_for :users
  resources :books
  root 'welcome#index'
  get 'search_book', to: 'books#search'
  get 'serve_book_search', to: 'books#serve_search'
  get 'book_to_add/:id', to: 'books#book_to_add', as: "book_to_add"
  post 'add_book/:id', to: 'books#add_book', as: "add_book"
end
