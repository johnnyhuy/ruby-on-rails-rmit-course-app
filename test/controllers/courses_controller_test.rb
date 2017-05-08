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

    # New Course
    @new_course = Course.new(
      name: 'Example Course',
      description: 'Example description' * 30,
    )

    # Different course
    @diff_course = courses(:web)

    # Location from fixture
    @location = locations(:locationOne)

    # Category from fixture
    @category = categories(:web)

    # Course params
    @course_params = {
      name: @new_course.name,
      description: @new_course.description,
      prerequisites: [@diff_course.id],
      locations: [@location.id],
      categories: [@category.id]
    }

    # Use a fixture for course
    @course = courses(:web)
  end

  test 'create course successful' do
    # Login as user
    login_as @user

    # Post params
    post courses_path, params: {course: @course_params}

    # Follow redirect
    follow_redirect!

    # Show success message
    assert flash[:success].present?

    # Should redirect login
    assert_equal request.path_info, courses_path
  end

  test 'course location does not exist' do
    # Login as user
    login_as @user

    # Location ID does not exist
    # Have an existing one in the array and vice versa
    @course_params[:locations] = [@location.id, 1337]

    # Post params
    post courses_path, params: {course: @course_params}

    # See if render is called
    assert_template 'courses/new'
  end

  test 'course category does not exist' do
    # Login as user
    login_as @user

    # Location ID does not exist
    # Have an existing one in the array and vice versa
    @course_params[:categories] = [@category, 1337]

    # Post params
    post courses_path, params: {course: @course_params}

    # See if render is called
    assert_template 'courses/new'
  end

  test 'should get new course and show title' do
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
