require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get register page" do
    get register_url
    assert_response :success
    assert_select "title", "Registration - RMIT Course App"
  end

  test "should get login page" do
    get login_url
    assert_response :success
    assert_select "title", "Login - RMIT Course App"
  end

  # test "register page stay on the same page after error" do
  #   get register_url
  #   post users_url,
  #     params: { user: @user_params }

  #   # Follow the redirect from controller
  #   follow_redirect!

  #   assert_equal request.path_info, register_path
  # end

  # test "register page flash errors should exist" do
  #   get register_url
  #   post users_url,
  #     params: { user: @user_params }
  #   follow_redirect!
  #   assert flash[:errors].present?
  # end
end
