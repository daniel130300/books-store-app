module Exceptions
    module CustomExceptions
        class FriendError < Exceptions::BaseException
          class MissingSearchTerms < CustomExceptions::FriendError
          end
        end
    end
end
  