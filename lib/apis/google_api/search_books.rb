module Apis
    module GoogleApi
        class SearchBooks
            BASE_URI = "https://www.googleapis.com/books/v1/volumes";

            def self.volumes(search_terms)   
                raise Exceptions::ApiExceptions::BookError::MissingSearchTerms if search_terms.blank?
                response = Apis::MyParty.get("#{BASE_URI}?q=#{search_terms}&maxResults=15&key=#{ENV["API_KEY"]}") 
                response.parsed_response["items"] if response
            end

            def self.volume(id)
                response = Apis::MyParty.get("#{BASE_URI}/#{id}?key=#{ENV["API_KEY"]}") 
                response.parsed_response
            end
        end
    end
end
  