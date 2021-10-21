# Preview all emails at http://localhost:3000/rails/mailers/friend_mailer
class FriendMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/friend_mailer/add_friend_back
  def add_friend_back
    user = User.first
    friend = user.friends.first
    FriendMailer.add_friend_back(friend, user)
  end

end
