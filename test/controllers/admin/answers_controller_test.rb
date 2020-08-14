require 'test_helper'

class Admin::AnswersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_answers_new_url
    assert_response :success
  end

end
