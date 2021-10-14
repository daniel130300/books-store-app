module Apis
    class SearchNewBooksValidator < ActiveModel::Validator
        def validate(record)
            validate_search_terms(record)
            validate_response(record)
        end
    
        def validate_search_terms(record)
            raise ApiExceptions::BookError::MissingSearchTerms.new if record.search_terms.empty?
        end

        def validate_response(record)
            raise ApiExceptions::BookError::BooksNotFound.new if record.books.nil?
        end
    end
end