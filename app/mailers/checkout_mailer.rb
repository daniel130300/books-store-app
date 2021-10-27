class CheckoutMailer < ApplicationMailer
    def personal_checkout(user, order, order_items, prices)
        @user = user
        @order = order
        @order_items = order_items
        @prices = prices
        mail to: user.email, subject: "Magic Books Store, your personal order has been confirmed!"
    end

    def book_to_friend_checkout(user, friend, order, order_book, prices)
        @user = user
        @friend = friend
        @order = order
        @order_book = order_book
        @prices = prices
        mail to: user.email, subject: "Magic Books Store, your #{friend.fullname} order has been confirmed!"
    end
end
