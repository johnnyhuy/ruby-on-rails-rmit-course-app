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

  test 'login successful without remember me' do
    get login_url
    post login_url,
      params: { session: @user_params }

    # Show success message
    assert flash[:success].present?

    # Follow
    follow_redirect!

    # Redirect page should by home page
    assert_equal request.path_info, root_path

    # User should be logged in
    assert logged_in?

    # Cookies should not exist
    assert cookies[:user_id].nil?
  end

  test 'login successful with remember me' do
    # Set remember me param to true
    @user_params[:remember_me] = 1

    get login_url
    post login_url,
      params: { session: @user_params }

    # Success message should exist
    assert flash[:success].present?

    # Follow
    follow_redirect!

    # Redirect page should by home page
    assert_equal request.path_info, root_path

    # User should be logged in
    assert logged_in?

    # Cookies should exist
    assert_not cookies[:user_id].nil?
  end

  test 'current user exists' do
    # Visit login page
    get login_url

    # Login
    post login_url,
      params: { session: @user_params }

    # Current user should exist
    assert_not current_user.nil?

    # Get the user via email
    user = User.find_by(email: @user_params[:email])

    # Found user information should be the same as current user
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
