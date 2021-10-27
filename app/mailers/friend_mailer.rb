class FriendMailer < ApplicationMailer
  def add_friend_back(friend, user)
    @user = user
    mail to: friend.email, subject: "#{user.email} has added you as a friend!"
  end
end
