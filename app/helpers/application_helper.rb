module ApplicationHelper

    def display_book_image(image_links, title)
        image_url = image_links.present? ? image_links["smallThumbnail"] : asset_url("none_image.jpeg")
        image_tag(image_url, alt:title, class:"img-fluid")
    end

    def display_book_text(text)
        text.present? ? truncate(text, :length => 300) : "None"
    end

end
