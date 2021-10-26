module Services
    class ProcessCartTransaction < ApplicationService
        TAX_RATE = 0.12
        attr_reader :cart_items, :friend, :current_user

        def initialize(current_user, cart_items, friend = nil)
            @current_user = current_user
            @friend = friend
            @cart_items = cart_items
        end

        def call
            @sale = Sale.new(user_id: current_user, friend_id: friend, sale_tax: TAX_RATE, address: user_address_to_string)
            if @sale.save
                ActiveRecord::Base.transaction do  
                    cart_items.each { |cart_item| 
                        SaleBook.new(
                            sale_id: @sale, 
                            book_id: cart_item[:book_id], 
                            quantity: cart_item[:quantity], 
                            price: cart_item[:sale_price]
                        ).save 
                    }
                    end
                end
            else 
                return false
            end
        end

        private
        def user_address_to_string
            "#{current_user.address.address_line_1}, 
            #{current_user.address.address_line_2.blank? ? "" : current_user.address.address_line_2 + ", "}
            #{current_user.address.city}, 
            #{current_user.address.state_or_province}, 
            #{current_user.address.postal_code}, 
            #{current_user.address.telephone}"
        end
    end
end