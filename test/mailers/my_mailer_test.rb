require 'test_helper'

class MyMailerTest < ActionMailer::TestCase
  test "send_new_user_email" do
    mail = MyMailer.send_new_user_email
    assert_equal "Send new user email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
