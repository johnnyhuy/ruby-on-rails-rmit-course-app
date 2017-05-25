class DownvotesController < ApplicationController
  # Middleware
  before_action :logged_users_only

  def new
    course = Course.find_by_id(params[:id])
    condition = { user_id: current_user.id, course_id: params[:id] }

    # If vote exists
    if Downvote.exists?(condition)
      flash_danger("You have already voted for #{course.name} course.", courses_path)
    elsif Upvote.exists?(condition)
      # Cannot allow course to be both upvote and downvote
      redirect_to courses_path, flash: { danger: "You have already upvoted #{course.name} course." }
    else
      # Add vote to DB
      course.downvotes << Downvote.create(user_id: current_user.id, course_id: course.id)
      redirect_to courses_path, flash: { success: "Successfully downvoted #{course.name} course." }
    end
  end
end