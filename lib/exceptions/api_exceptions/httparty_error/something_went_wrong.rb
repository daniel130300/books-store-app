module Exceptions
    module ApiExceptions
        class HttpartyError < Exceptions::BaseException
          class SomethingWentWrong < ApiExceptions::HttpartyError
          end
        end
    end
end