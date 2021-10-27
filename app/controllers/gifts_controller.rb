class GiftsController < ApplicationController

    def index
        @gifted_books = current_user.sale_books.includes(:book)
    end

end

