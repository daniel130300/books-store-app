module Exceptions
    module ApiExceptions
        class FriendError < Exceptions::BaseException
          class MissingSearchTerms < ApiExceptions::FriendError
          end
        end
    end
end
  