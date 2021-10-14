module ApiExceptions
    class BookError < ApiExceptions::BaseException
      class MissingSearchTerms < ApiExceptions::BookError
      end
    end
end