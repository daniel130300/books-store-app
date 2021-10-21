class FriendMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.friend_mailer.add_friend_back.subject
  #
  def add_friend_back(friend, user)
    @friend = friend
    mail to: friend.email, subject: " The user #{user.fullname} with email #{user.email} has added you as a friend!"
  end
end
