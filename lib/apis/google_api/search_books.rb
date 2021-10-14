module Apis
    module GoogleApi
        class SearchBooks
            BASE_URI = "https://www.googleapis.com/books/v1/volumes";

            def self.volumes(search_terms)   
                raise Apis::ApiExceptions::BookError::MissingSearchTerms if search_terms.blank?
                response = HTTParty.get("#{BASE_URI}?q=#{search_terms}&maxResults=15&key=#{ENV["API_KEY"]}") 
                response.parsed_response["items"]
            end

            def self.volume(id)
                response = HTTParty.get("#{BASE_URI}/#{id}?key=#{ENV["API_KEY"]}") 
                response.parsed_response
            end
        end
    end
end
  