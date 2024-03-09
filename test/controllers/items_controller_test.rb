require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get items_search_url
    assert_response :success
  end
end
