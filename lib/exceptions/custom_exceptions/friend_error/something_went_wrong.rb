module Exceptions
    module CustomExceptions
        class FriendError < Exceptions::BaseException
          class SomethingWentWrong < CustomExceptions::FriendError
          end
        end
    end
end