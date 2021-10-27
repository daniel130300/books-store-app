# Preview all emails at http://localhost:3000/rails/mailers/checkout_mailer
class CheckoutMailerPreview < ActionMailer::Preview
    def personal_checkout
        user = User.second
        order = Sale.new(id: 40, user_id: user.id, friend_id: nil, sale_tax: 0.12)
        order_items = user.shopping_carts.includes(:book).order(:book_id)
        prices = Services::GetCartPrices.call(order_items)
        CheckoutMailer.personal_checkout(user, order, order_items, prices)
    end

    def book_to_friend_checkout
        user = User.second
        friend = User.first
        order = Sale.new(id: 41, user_id: user.id, friend_id: friend.id, sale_tax: 0.12)
        order_items = user.shopping_carts.includes(:book).order(:book_id)
        prices = Services::GetCartPrices.call(order_items)
        CheckoutMailer.book_to_friend_checkout(user, friend, order, order_items, prices)
    end
end
