require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user_params = {
      name: '',
      email: '',
      password: '',
      password_confirmation: '',
    }
  end

  test "should get new" do
    get register_url
    assert_response :success
    assert_select "title", "Registration - RMIT Course App"
  end

  test "register page stay on the same page after error" do
    post users_url,
      params: { user: @user_params }

    # Follow the redirect from controller
    follow_redirect!

    assert_equal request.path_info, register_path
  end

  test "register page flash errors should exist" do
    post users_url,
      params: { user: @user_params }
    follow_redirect!
    assert flash[:errors].present?
  end
end
