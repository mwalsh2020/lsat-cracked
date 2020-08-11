require 'test_helper'

class WebMailerTest < ActionMailer::TestCase
  test "coaching" do
    mail = WebMailer.coaching
    assert_equal "Coaching", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
