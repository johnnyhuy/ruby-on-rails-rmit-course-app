require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  def setup
    # User parameters
    @user_params = {
      email: 'example@email.com',
      password: 'Password123',
    }

    # Create an existing user
    User.create(
      name: 'Example User',
      email: @user_params[:email],
      password: @user_params[:password],
      password_confirmation: @user_params[:password]
    )
  end

  test 'should get new' do
    get login_url
    assert_response :success
  end

  test 'login successful' do
    get login_url
    post login_url,
      params: { session: @user_params }

    # Show success message
    assert flash[:success].present?

    # Follow
    follow_redirect!

    # Check if page redirects to home page
    assert_equal request.path_info, root_path

    # Check if user is logged in
    assert logged_in?
  end

  test 'current user exists' do
    # Visit login page
    get login_url

    # Login
    post login_url,
      params: { session: @user_params }

    # Check if current user exists
    assert_not current_user.nil?

    # Get the user via email
    user = User.find_by(email: @user_params[:email])

    # Check user information is the same
    assert_equal current_user.name, user.name
    assert_equal current_user.email, user.email
  end

  test 'invalid login details' do
    get login_url

    # Set email and password as empty
    @user_params[:email] = ''
    @user_params[:password] = ''

    # Send post request to login
    post login_url,
      params: { session: @user_params }
    assert flash[:danger].present?
  end
end
