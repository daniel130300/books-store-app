module Exceptions
  module ApiExceptions
      class BookError < Exceptions::BaseException
        class MissingSearchTerms < ApiExceptions::BookError
        end
      end
  end
end
