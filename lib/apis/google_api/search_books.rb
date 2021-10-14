module Apis
    module GoogleApi
        class SearchBooks
            @@base_uri = "https://www.googleapis.com/books/v1/volumes";

            def self.volumes(search_terms)   
                raise ArgumentError if search_terms.blank?
                begin
                    response = HTTParty.get("#{@@base_uri}?q=#{search_terms}&maxResults=15&key=#{ENV["API_KEY"]}") 
                    raise StandardError if response.parsed_response["items"].blank? 
                    response.parsed_response["items"]
                rescue HTTParty::Error
                    raise Errors::HttpartyError
                rescue StandardError
                    raise Errors::StandardApiError
                end
            end

            def self.volume(id)
                begin
                    response = HTTParty.get("#{@@base_uri}/#{id}?key=#{ENV["API_KEY"]}") 
                    raise StandardError if !response.parsed_response["error"].blank?
                    response.parsed_response
                rescue HTTParty::Error
                    raise Errors::HttpartyError
                rescue StandardError
                    raise Errors::StandardApiError
                end
            end
        end
    end
end
  