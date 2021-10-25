class Sale < ApplicationRecord
    belongs_to :user
    belongs_to :friend, class_name: 'User'
    has_many :sale_books
    has_many :books, through: :sale_books
end