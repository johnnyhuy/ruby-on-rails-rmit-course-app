require 'test_helper'

class UserRegisterTest < ActionDispatch::IntegrationTest
  def setup
    # User parameters
    # An ideal valid user
    @user_params = {
      name: 'Example User',
      email: 'example@email.com',
      password: 'Password123',
      password_confirmation: 'Password123',
    }
  end

  test "invalid signup information" do
    get register_path

    # Check if total user count changes
    assert_no_difference 'User.count' do
      # Make a mistake in the param
      # In this case it's the empty name
      @user_params[:name] = ''

      # Post request data
      post users_path, params: { user: @user_params }
    end

    assert_template 'users/new'
  end

  test 'register successful' do
    get register_path
    post users_path, params: { user: @user_params }

    # Follow
    follow_redirect!

    # Show success message
    assert flash[:success].present?

    # Check if page redirects to login page
    assert_equal request.path_info, login_path
  end
end