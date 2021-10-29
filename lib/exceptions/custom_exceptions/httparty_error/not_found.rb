module Exceptions
    module CustomExceptions
        class HttpartyError < Exceptions::BaseException
          class NotFound < CustomExceptions::HttpartyError
          end
        end
    end
end