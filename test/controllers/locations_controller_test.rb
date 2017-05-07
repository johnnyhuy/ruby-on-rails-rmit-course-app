require 'test_helper'

class LocationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    # Create an existing user
    @user = User.create(
      firstname: 'Example',
      lastname: 'User',
      email: 'example.user@rmit.edu.au',
      password: 'Password123',
      password_confirmation: 'Password123'
    )

    # Use a fixture for location
    @location = locations(:locationOne)
  end

  test "guest should not create locations" do
    # Visit new location path
    get new_location_path

    # Follow redirect
    follow_redirect!

    # Should redirect login
    assert_equal request.path_info, login_path

    # Attempt to create a location through POST
    post locations_path

    # Follow redirect
    follow_redirect!

    # Should redirect login
    assert_equal request.path_info, login_path
  end

  test 'guest and logged in user can visit individual location page' do
    # Visit all locations path
    get locations_path(@location)

    # Should have no redirection
    assert_response :success

    # Login as location
    login_as @user

    # Visit all locations path
    get locations_path(@location)

    # Should have no redirection
    assert_response :success
  end
end
