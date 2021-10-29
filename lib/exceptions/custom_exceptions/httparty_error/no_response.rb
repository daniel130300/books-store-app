module Exceptions
    module CustomExceptions
        class HttpartyError < Exceptions::BaseException
          class NoResponse < CustomExceptions::HttpartyError
          end
        end
    end
end
  