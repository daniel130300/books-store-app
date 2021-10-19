module Services 
    class CreateOrAddAuthors < ApplicationService
      def call (full_name, book) 
          author = Author.check_author(full_name) 
          if author.blank? 
              author = Author.new(full_name: full_name)
              author.save
          end
          book.authors << author
      end
      end
    end
  end