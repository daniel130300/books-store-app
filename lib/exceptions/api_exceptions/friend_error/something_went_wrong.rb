module Exceptions
    module ApiExceptions
        class FriendError < Exceptions::BaseException
          class SomethingWentWrong < ApiExceptions::FriendError
          end
        end
    end
end