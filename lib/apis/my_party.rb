module Apis
    class MyParty
        def self.get(*args)
            begin
                response = HTTParty.get(*args)
                case response.code
                    when 200
                        return response
                    when 404
                        raise Exceptions::ApiExceptions::HttpartyError::NotFound
                    when 500...600
                        raise Exceptions::ApiExceptions::HttpartyError::NoResponse
                end
            rescue StandardError
                raise Exceptions::ApiExceptions::HttpartyError::SomethingWentWrong
            rescue HTTParty::Error 
                raise Exceptions::ApiExceptions::HttpartyError::SomethingWentWrong
            end
        end
    end
end