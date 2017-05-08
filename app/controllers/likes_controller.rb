class LikesController < ApplicationController
  # Middleware
  before_action :logged_users_only, only: [:like, :dislike]

  def new
    course = Course.find_by_id(params[:id])
    condition = { user_id: current_user.id, course_id: params[:id] }

    # If like exists
    if Like.exists?(condition)
      redirect_to courses_path, flash: { info: "You have unliked course #{course.name}." }

      # Unlike
      Like.find_by(condition).destroy
    elsif Dislike.exists?(condition)
      # Cannot allow course to be both like and dislike
      redirect_to courses_path, flash: { danger: "You have already disliked course #{course.name}." }
    else
      # Add like to DB
      course.likes << Like.create(user_id: current_user.id, course_id: course.id)
      redirect_to courses_path, flash: { success: "Successfully liked course #{course.name}." }
    end
  end
end