require "test_helper"

class Admins::CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admins_comments_index_url
    assert_response :success
  end
end
