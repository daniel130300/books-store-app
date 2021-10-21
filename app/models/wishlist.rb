class Wishlist < ApplicationRecord
    belongs_to :user
    belongs_to :book

    def self.is_book_owner?(book, user)
        self.where(user_id: user, book_id: book).exists?
    end
end
  