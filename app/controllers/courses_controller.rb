class CoursesController < ApplicationController
  include CoursesHelper

  # Middleware
  before_action :logged_users_only, except: [:index, :show]

  def index
    @courses = Course.all
  end

  def create
    @locations = Location.all
    @categories = Category.all
    @prerequisites = Prerequisite.all
    @courses = Course.all

    # Get course params
    course_param = params.require(:course).permit([:name, :description])

    # New course
    @course = Course.new(course_param)

    # Get external params from course
    external_params = params.require(:course).permit([:prerequisites => [], :locations => [], :categories => []])

    # Clean array if it contains an empty string
    external_params.each do |k, v|
      external_params[k].clean_empty
    end

    # Validate collection first
    @course.valid?

    # Add custom errors after call
    @course.errors.add(:base, "Prerequisite can't be blank") if external_params[:prerequisites].empty?
    @course.errors.add(:base, "Location can't be blank") if external_params[:locations].empty?
    @course.errors.add(:base, "Category can't be blank") if external_params[:categories].empty?

    # Save course
    if @course.errors.any?
      render 'new'
    else
      # New prerequisite
      external_params[:prerequisites].each do |p|
        # Check if location exists
        if !Course.exists?(id: p)
          # Make sure to render and return
          @course.errors.add(:base, "Prerequisite does not exist")
          render 'new'
          return
        end
      end

      # New location
      external_params[:locations].each do |l|
        # Check if location exists
        if Location.exists?(id: l)
          @course.locations << Location.find_by_id(l)
        else
          # Make sure to render and return
          @course.errors.add(:base, "Location does not exist")
          render 'new'
          return
        end
      end

      # New category
      external_params[:categories].each do |c|
        # Check if category exists
        if Category.exists?(id: c)
          @course.categories << Category.find_by_id(c)
        else
          # Make sure to render and return
          @course.errors.add(:base, "Category does not exist")
          render 'new'
          return
        end
      end

      # Set user ID to logged in user
      @course.user_id = current_user.id

      # Save course
      @course.save

      # Create prerequisite after save
      # Since it needs a course ID
      external_params[:prerequisites].each do |p|
        Prerequisite.create(id: p, course_id: @course.id)
      end

      # Handle a successful save.
      redirect_to courses_path, flash: { success: "Successfully created #{@course.name} course!" }
    end
  end

  def new
    @locations = Location.all
    @categories = Category.all
    @prerequisites = Prerequisite.all
    @courses = Course.all
    @course = Course.new
  end

  def show
    @course = Course.find(params[:id])
  end
end
