module ApiExceptions
    class BookError < ApiExceptions::BaseException
      class BooksNotFound < ApiExceptions::BookError
      end
    end
end