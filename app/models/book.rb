class Book < ApplicationRecord
    include PgSearch::Model

    has_many :book_authors
    has_many :authors, through: :book_authors
    has_many :wishlists
    has_many :users, through: :wishlists
    
    pg_search_scope :search_book, 
    against: [:title, :publisher, :description],
    associated_against: {
        authors: :full_name
    },
    using: {
        tsearch: {dictionary: "english", prefix: true }
    }

    validates :purchase_price, presence: true, length: {minimum:1, maximum:7}, numericality: true
    validates :sale_price, presence: true, length: {minimum:1, maximum:7}, numericality: true
    validates :quantity, presence: true, length: {minimum:1, maximum:3}, numericality: { only_integer: true }
    validates :external_id, presence: true, uniqueness: { case_sensitive: false, message: "book has been already added" }

    def self.check_book(external_id)
        where(external_id: external_id).first
    end
end
