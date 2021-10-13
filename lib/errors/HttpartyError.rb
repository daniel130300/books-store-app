module Errors
    class HttpartyError < HTTParty::Error
        attr_reader :response_code, :response_body
    
        def initialize(message = "Httparty couldn't execute the api call", response_code = nil, response_body = nil)
            @response_code = response_code
            @response_body = response_body

            super(message)
        end
    end
end