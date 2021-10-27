module Services
    class ProcessCartTransaction
        TAX_RATE = 0.12
        attr_reader :error, :current_user, :friend, :cart_items

        def initialize(current_user, cart_items, friend = nil)
            @current_user = current_user
            @friend = friend
            @cart_items = cart_items
            @error = nil
        end

        def call
            not_available_as_requested = []
            ActiveRecord::Base.transaction do 
                sale = Sale.new(user_id: @current_user[:id], friend_id: @friend, sale_tax: TAX_RATE, address: user_address_to_string)
                sale.save!
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
                        cart_book_to_update = current_user.shopping_carts.where(book_id: cart_item.book_id).first 
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
            !messages.blank? ? (raise ActiveRecord::Rollback, "#{messages}") : (current_user.shopping_carts.destroy_all)
            return true
        rescue => e
            @error = e.message
            return false
        end

        private

        def personal_cart_transaction
            
        end

        def friend_cart_transaction
            
        end

        def user_address_to_string
            "
            Address line 1: #{@current_user.address.address_line_1}, 
            Address line 2: #{@current_user.address.address_line_2.blank? ? "" : current_user.address.address_line_2 + ", "}
            City: #{@current_user.address.city}, 
            State or province: #{@current_user.address.state_or_province}, 
            Postal code: #{@current_user.address.postal_code}, 
            Telephone: #{@current_user.address.telephone}
            "
        end
    end
end