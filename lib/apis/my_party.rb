module Apis
    class MyParty
        def self.get(*args)
            begin
                response = HTTParty.get(*args)
                case response.code
                    when 200
                        return response
                    when 404
                        raise Exceptions::CustomExceptions::HttpartyError::NotFound
                    when 500...600
                        raise Exceptions::CustomExceptions::HttpartyError::NoResponse
                end
            rescue
                raise Exceptions::CustomExceptions::HttpartyError::SomethingWentWrong
            end
        end
    end
end