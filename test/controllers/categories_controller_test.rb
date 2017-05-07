require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    # Create an existing user
    @user = User.create(
      firstname: 'Example',
      lastname: 'User',
      email: 'example.user@rmit.edu.au',
      password: 'Password123',
      password_confirmation: 'Password123'
    )

    # Use a fixture for category
    @category = categories(:web)
  end

  test "guest should not create categories" do
    # Visit new category path
    get new_category_path

    # Follow redirect
    follow_redirect!

    # Should redirect login
    assert_equal request.path_info, login_path

    # Attempt to create a category through POST
    post categories_path

    # Follow redirect
    follow_redirect!

    # Should redirect login
    assert_equal request.path_info, login_path
  end

  test 'guest and logged in user can visit individual category page' do
    # Visit all categories path
    get categories_path(@category)

    # Should have no redirection
    assert_response :success

    # Login as category
    login_as @user

    # Visit all categories path
    get categories_path(@category)

    # Should have no redirection
    assert_response :success
  end
end
