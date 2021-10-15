module Apis
    class MyParty
        def self.get(*args)
            begin
                response = HTTParty.get(*args)
                if response.code == 404
                    raise Exceptions::ApiExceptions::HttpartyError::NotFound
                elsif response.code == 500..600
                    raise Exceptions::ApiExceptions::HttpartyError::NoResponse
                else
                    response
                end
            rescue StandardError
                raise Exceptions::ApiExceptions::HttpartyError::SomethingWentWrong
            rescue HTTParty::Error 
                raise Exceptions::ApiExceptions::HttpartyError::SomethingWentWrong
            end
        end
    end
end