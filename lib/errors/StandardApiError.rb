module Errors
    class StandardApiError < StandardError
    attr_reader :response_code, :response_body
    
    def initialize(message, response_code = nil, response_body = nil)
        @response_code = response_code
        @response_body = response_body

        super(message)
    end
end