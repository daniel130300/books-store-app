module Services
    class ProcessCartTransaction
        TAX_RATE = 0.12
        attr_reader :error, :sale, :cart_items, :friend

        def initialize(current_user, cart_items, friend = nil)
            @current_user = current_user
            @friend = friend
            @cart_items = cart_items
            @error = nil
        end

        def call
            if @friend.blank?
                personal_cart_transaction
            else
                friend_cart_transaction
            end
        end

        private

        def personal_cart_transaction
            not_available_as_requested = []
            ActiveRecord::Base.transaction do 
                @sale = Sale.new(user_id: @current_user[:id], friend_id: @friend, sale_tax: TAX_RATE, address: user_address_to_string(@current_user))
                @sale.save!
                @cart_items.each do |cart_item|
                    if Book.check_book_availability(cart_item.book_id, cart_item.quantity)
                        SaleBook.new(
                            sale_id: sale.id, 
                            book_id: cart_item.book_id, 
                            quantity: cart_item.quantity, 
                            price: cart_item.book.sale_price
                        ).save!
                        inventory_book = Book.where(id:cart_item.book_id).first
                        inventory_book.update_attribute(:stock, inventory_book.stock - cart_item.quantity)
                    else
                        inventory_book = Book.where(id:cart_item.book_id).first
                        cart_book_to_update = @current_user.shopping_carts.where(book_id: cart_item.book_id).first 
                        if inventory_book.stock > 0 
                            cart_book_to_update.update_attribute(:quantity, inventory_book.stock)
                            not_available_as_requested.push("Sorry for the inconvenient, we have updated the book #{cart_item.book.title}" "to the current units left" )
                        else
                            not_available_as_requested.push("Sorry for the inconvenient, there are no units left for the book #{cart_item.book.title}")
                        end
                    end 
                end
            end
            messages = not_available_as_requested.join(", ")
            !messages.blank? ? (raise ActiveRecord::Rollback, "#{messages}") : (@current_user.shopping_carts.destroy_all)
            return true
        rescue => e
            @error = e.message
            return false
        end

        def friend_cart_transaction
            not_available_as_requested = ""
            ActiveRecord::Base.transaction do 
                @sale = Sale.new(user_id: @current_user[:id], friend_id: @friend[:id], sale_tax: TAX_RATE, address: user_address_to_string(@friend))
                @sale.save!
                if Book.check_book_availability(@cart_items.id, 1)
                    SaleBook.new(
                        sale_id: sale.id, 
                        book_id: @cart_items.id, 
                        quantity: 1, 
                        price: @cart_items.sale_price
                    ).save!
                    inventory_book = Book.where(id:@cart_items.id).first
                    inventory_book.update_attribute(:stock, inventory_book.stock - 1)
                else
                    not_available_as_requested = "Sorry for the inconvenient, there are no units left for the book #{@cart_items.title}"
                end
            end
            (raise ActiveRecord::Rollback, "#{not_available_as_requested}") if !not_available_as_requested.blank? 
            return true
        rescue => e
            @error = e.message
            return false
        end

        def user_address_to_string(user)
            "
            Address line 1: #{user.address.address_line_1}, 
            Address line 2: #{user.address.address_line_2.blank? ? "" : user.address.address_line_2 + ", "}
            City: #{user.address.city}, 
            State or province: #{user.address.state_or_province}, 
            Postal code: #{user.address.postal_code}, 
            Telephone: #{user.address.telephone}
            "
        end
    end
end