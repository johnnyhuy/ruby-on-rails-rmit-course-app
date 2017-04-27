require 'test_helper'

class UserLogoutTest < ActionDispatch::IntegrationTest
  test 'logout successful' do
    # Send destory request type to logout
    delete logout_path

    # Check if success message exists
    assert_not flash[:success].nil?

    # Check if current user does not exist
    assert current_user.nil?

    # Check if user is not logged in
    assert_not logged_in?
  end
end
