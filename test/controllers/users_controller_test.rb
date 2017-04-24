require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get register_url
    assert_response :success
    assert_select "title", "Registration - RMIT Course App"
  end

end
