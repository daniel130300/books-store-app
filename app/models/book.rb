class Book < ApplicationRecord

    has_many :book_authors
    has_many :authors, through: :book_authors

    validates :purchase_price, presence: true, length: {minimum:1, maximum:7}, numericality: true
    validates :sale_price, presence: true, length: {minimum:1, maximum:7}, numericality: true
    validates :quantity, presence: true, length: {minimum:1, maximum:3}, numericality: { only_integer: true }
    validates :external_id, presence: true, uniqueness: { case_sensitive: false, message: "book has been already added" }

    def self.check_book(external_id)
        where(external_id: external_id).first
    end
end
