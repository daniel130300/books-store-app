module Exceptions
    module CustomExceptions
        class HttpartyError < Exceptions::BaseException
          class SomethingWentWrong < CustomExceptions::HttpartyError
          end
        end
    end
end