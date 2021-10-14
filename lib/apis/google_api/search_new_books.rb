module Apis
    module GoogleApi
        class SearchNewBooks
            attr_reader :search_terms, :books
            include ActiveModel::Validations
            validates_with Apis::SearchNewBooksValidator
          
            @@base_uri = "https://www.googleapis.com/books/v1/volumes";

            def initialize(search_terms)
                @search_terms = search_terms
                @books = HTTParty.get("#{@@base_uri}?q=#{@search_terms}&maxResults=15&key=#{ENV["API_KEY"]}").parsed_response["items"]
                @books if valid?
            end
        end
    end
end