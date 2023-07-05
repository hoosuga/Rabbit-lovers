require "test_helper"

class Admins::RoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admins_rooms_index_url
    assert_response :success
  end

  test "should get show" do
    get admins_rooms_show_url
    assert_response :success
  end
end
