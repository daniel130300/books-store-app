module Exceptions
  module CustomExceptions
      class BookError < Exceptions::BaseException
        class MissingSearchTerms < CustomExceptions::BookError
        end
      end
  end
end
