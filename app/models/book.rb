class Book < ApplicationRecord

    def self.search(search_terms)   
        url = "https://www.googleapis.com/books/v1/volumes?q=#{search_terms}&maxResults=15&key=#{ENV["API_KEY"]}"
        response = HTTParty.get(url)

        case response.code
            when 200
            result = response.parsed_response
            result["items"]
            when 404
            return false
            when 500...600
            return nil
            byebug
        end
    end
end
