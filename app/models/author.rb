class Author < ApplicationRecord

    has_many :book_authors
    has_many :books, through: :book_authors

    def self.check_author(full_name)
        where(full_name: full_name).first
    end
end

