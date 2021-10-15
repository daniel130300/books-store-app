Rails.application.routes.draw do
  devise_for :users
  resources :books
  root 'welcome#index'
  get 'search_book', to: 'books#search'
  get 'serve_book_search', to: 'books#serve_search'
  get 'book_to_add', to: 'books#book_to_add'
  post 'add_book', to: 'books#add_book'
end
