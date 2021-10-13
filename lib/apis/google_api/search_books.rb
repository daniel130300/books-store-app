module Apis
    module GoogleApi
        class SearchBooks
            def self.volumes(search_terms)   
                raise ArgumentError if search_terms.blank?
                begin
                    response = HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=#{search_terms}&maxResults=15&key=#{ENV["API_KEY"]}")
                    response.parsed_response["items"]
                rescue HTTParty::Error
                    raise Errors::HttpartyError("Google Books API couldn't be called", response_code = response.code)
                    false
                rescue StandardError
                    raise Errors::StandardApiError("Error getting books information from the Google Books API", response_code = response.code) 
                    false
                end
            end
        end
    end
end
  