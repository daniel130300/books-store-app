class CheckoutMailer < ApplicationMailer
    def personal_checkout (user)
        @user = user
        mail to: user.email, subject: "Magic Books Store, your personal order has been confirmed!"
    end

    def book_to_friend_checkout(user, friend)
        @user = user
        mail to: user.email, subject: "Magic Books Store, your #{friend.fullname} order has been confirmed!"
    end
end
