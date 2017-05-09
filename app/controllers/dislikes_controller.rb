class DislikesController < ApplicationController
  # Middleware
  before_action :logged_users_only

  def new
    course = Course.find_by_id(params[:id])
    condition = { user_id: current_user.id, course_id: params[:id] }

    # If like exists
    if Dislike.exists?(condition)
      redirect_to courses_path, flash: { info: "You have unliked course #{course.name}." }

      # Unlike
      Dislike.find_by(condition).destroy
    elsif Like.exists?(condition)
      # Cannot allow course to be both like and dislike
      redirect_to courses_path, flash: { danger: "You have already liked course #{course.name}." }
    else
      # Add like to DB
      course.dislikes << Dislike.create(user_id: current_user.id, course_id: course.id)
      redirect_to courses_path, flash: { success: "Successfully disliked course #{course.name}." }
    end
  end
end