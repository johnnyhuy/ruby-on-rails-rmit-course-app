require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  def setup
    # User parameters
    @user_params = {
      email: 'example@email.com',
      password: 'Password123',
    }

    # Create an existing user
    @user = User.create(
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

    # Redirect page should by home page
    assert_equal request.path_info, root_path

    # User should be logged in
    assert logged_in_session?

    # Cookies should not exist
    assert cookies[:user_id].nil?
  end

  test 'login with remembering' do
    login_as @user, remember_me: '1'

    # Success message should exist
    assert flash[:success].present?

    # Follow
    follow_redirect!

    # Redirect page should by home page
    assert_equal request.path_info, root_path

    # User should be logged in
    assert logged_in_session?

    # Simulate session expire
    session[:user_id] = nil

    # Remember token should exist in cookie
    assert_not_empty cookies['remember_token']
  end

  test 'no remember token' do
    assert_not @user.authenticated?('')
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
