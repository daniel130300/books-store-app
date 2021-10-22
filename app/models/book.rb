class Book < ApplicationRecord
    include PgSearch::Model

    attr_accessor :wish_book_owner, :already_in_wishlist

    has_many :book_authors
    has_many :authors, through: :book_authors
    has_many :wishlists
    has_many :wish_users, through: :wishlists, source: 'user'
    has_many :shopping_carts
    has_many :cart_users, through: :shopping_carts, source: 'user'
    
    pg_search_scope :search_book, 
    against: [:title, :publisher, :description],
    associated_against: {
        authors: :full_name
    },
    using: {
        tsearch: {dictionary: "english", prefix: true }
    }

    validates :purchase_price, presence: true, length: { minimum:1, maximum:7 }, numericality: { greater_than: 0, less_than: 10000 } 
    validates :sale_price, presence: true, length: { minimum:1, maximum:7 }, numericality: { greater_than: :purchase_price, message: 'must be greater than purchase price' }
    validates :sale_price, numericality: { less_than: 10000 }
    validates :quantity, presence: true, length: { minimum:1, maximum:6 }, numericality: { only_integer: true, greater_than: 0, less_than: 100000 }
    validates :external_id, presence: true, uniqueness: { case_sensitive: false, message: "book has been already added" }

    before_validation :sanitize_params

    def self.check_book(external_id)
        where(external_id: external_id).first
    end

    private 
    def sanitize_params
        self.title = self.title.titleize
        self.quantity = self.quantity.to_i
        self.purchase_price = self.purchase_price.to_f
        self.sale_price = self.sale_price.to_f
        self.average_rating = self.average_rating.blank? ? nil : self[:average_rating].to_i
    end
end
