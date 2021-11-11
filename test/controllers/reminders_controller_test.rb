require "test_helper"

class RemindersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reminders_index_url
    assert_response :success
  end
end
