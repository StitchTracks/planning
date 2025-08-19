require "test_helper"

class ChunksControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get chunks_edit_url
    assert_response :success
  end
end
