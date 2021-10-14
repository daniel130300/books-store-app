Rails.application.routes.draw do
  resources :books
  devise_for :users
  root 'welcome#index'
  get 'search_book', to: 'books#search'
  get 'serve_book_search', to: 'books#serve_search'
  get 'book_to_add', to: 'books#book_to_add'
end
