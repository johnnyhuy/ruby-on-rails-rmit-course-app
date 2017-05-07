require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  def setup
    # Create an existing user
    @user = User.create(
      firstname: 'Example',
      lastname: 'User',
      email: 'example.user@rmit.edu.au',
      password: 'Password123',
      password_confirmation: 'Password123'
    )

    # Use a fixture for course
    @course = courses(:web)
  end

  test "should get new course and show title" do
    # Login as user
    login_as @user

    # Visit new course page
    get new_course_url

    # Should successfully load
    assert_response :success

    # Should have a proper title
    assert_select "title", "New Course - RMIT Course App"
  end

  test 'guest cannot create courses' do
    # Visit new course path
    get new_course_path

    # Follow redirect
    follow_redirect!

    # Should redirect login
    assert_equal request.path_info, login_path

    # Attempt to create a course through POST
    post courses_path

    # Follow redirect
    follow_redirect!

    # Should redirect login
    assert_equal request.path_info, login_path
  end

  test 'guest and logged in user can visit all courses' do
    # Visit all courses path
    get courses_path

    # Should have no redirection
    assert_response :success

    # Login as user
    login_as @user

    # Visit all courses path
    get courses_path

    # Should have no redirection
    assert_response :success
  end

  test 'logged in user and guest can visit individual courses' do
    # Visit all courses path
    get courses_path(@course)

    # Should have no redirection
    assert_response :success

    # Login as user
    login_as @user

    # Visit all courses path
    get courses_path(@course)

    # Should have no redirection
    assert_response :success
  end
end
