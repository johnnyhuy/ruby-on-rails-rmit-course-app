require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  test "should get new course and show title" do
    get new_course_url
    assert_response :success
    assert_select "title", "New Course - RMIT Course App"
  end
end
