class ShoppingCart < ApplicationRecord
    belongs_to :user
    belongs_to :book

    def check_book_availabilty(user, book, quantity)
        self.where(user_id: user, book_id: book).first.quantity >= quantity
    end
end