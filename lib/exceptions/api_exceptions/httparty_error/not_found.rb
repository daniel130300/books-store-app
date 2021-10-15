module Exceptions
    module ApiExceptions
        class HttpartyError < Exceptions::BaseException
          class NotFound < ApiExceptions::HttpartyError
          end
        end
    end
end