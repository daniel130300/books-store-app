module ApplicationHelper

    def book_image_url(image_links)
        image_url = image_links.present? ? image_links["smallThumbnail"] : "#"#asset_url("none_image.jpeg")
        image_url
    end

    def book_text(text)
        text.present? ? text.html_safe : "None"
    end

    def limit_text(text)
        truncate(text, :length => 300)
    end

    def format_authors(authors)
        authors.blank? ? nil : authors.join(", ")
    end

    def author_names(authors)
        authors.map { |author| author.full_name } 
    end
end
