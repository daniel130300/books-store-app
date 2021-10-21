require "test_helper"

class FriendMailerTest < ActionMailer::TestCase
  test "add_friend_back" do
    mail = FriendMailer.add_friend_back
    assert_equal "Add friend back", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
