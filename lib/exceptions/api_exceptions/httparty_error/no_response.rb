module Exceptions
    module ApiExceptions
        class HttpartyError < Exceptions::BaseException
          class NoResponse < ApiExceptions::HttpartyError
          end
        end
    end
end
  