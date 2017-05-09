class CoursesController < ApplicationController
  include CoursesHelper

  # Middleware
  before_action :logged_users_only, except: [:index, :show]

  def create
    @locations = Location.all
    @categories = Category.all
    @prerequisites = Prerequisite.all
    @courses = Course.all

    # Get course params
    course_params = params.require(:course).permit([:name, :description])

    # New course
    @course = Course.new(course_params)

    # Validate collection first
    @course.valid?

    # Get course params
    course_params = params.require(:course).permit([:name, :description, :prerequisites => [], :locations => [], :categories => []])

    # Clean array if it contains an empty string
    course_params.each do |k, v|
      course_params[k].clean_empty if course_params[k].kind_of?(Array)
    end

    # Add custom errors after call
    # Disabled Prerequisite since it can be optional
    # course.errors.add(:base, "Prerequisite can't be blank") if course_params[:prerequisites].empty?
    @course.errors.add(:base, "Location can't be blank") if course_params[:locations].empty?
    @course.errors.add(:base, "Category can't be blank") if course_params[:categories].empty?

    # Save course
    if @course.errors.any?
      render 'new'
    else
      # New location
      course_params[:locations].each do |l|
        @course.locations << Location.find(l)
      end

      # New category
      course_params[:categories].each do |c|
        @course.categories << Category.find(c)
      end

      # Save course
      @course.save

      # Create prerequisites
      course_params[:prerequisites].each do |p|
        Prerequisite.create(id: p, course_id: @course.id)
      end

      redirect_to courses_path, flash: { success: "Successfully created #{@course.name} course!" }
    end
  end

  def edit
    @course = Course.find(params[:id])
    @courses = Course.where.not(id: params[:id])
    @prerequisites = Prerequisite.all
    @locations = Location.all
    @categories = Category.all
  end

  def index
    @courses = Course.all
  end

  def new
    @courses = Course.all
    @course = Course.new
    @prerequisites = Prerequisite.all
    @locations = Location.all
    @categories = Category.all
  end

  def show
    @course = Course.find(params[:id])
  end

  def update
    @courses = Course.where.not(id: params[:id])
    @course = Course.find(params[:id])
    @prerequisites = Prerequisite.all
    @locations = Location.all
    @categories = Category.all

    # Get course params
    course_params = params.require(:course).permit([:name, :description, :prerequisites => [], :locations => [], :categories => []])

    # Clean array if it contains an empty string
    course_params.each do |k, v|
      course_params[k].clean_empty if course_params[k].kind_of?(Array)
    end

    @course.name = course_params[:name]
    @course.description = course_params[:description]

    # Validate collection first
    @course.valid?

    # Add custom errors after call
    # Disabled Prerequisite since it can be optional
    # course.errors.add(:base, "Prerequisite can't be blank") if course_params[:prerequisites].empty?
    @course.errors.add(:base, "Location can't be blank") if course_params[:locations].empty?
    @course.errors.add(:base, "Category can't be blank") if course_params[:categories].empty?

    # Save course
    if @course.errors.any?
      render 'edit'
    else
      # Update course details
      @course.update_attribute(:name, course_params[:name])
      @course.update_attribute(:description, course_params[:description])

      # Delete previous prerequisites
      @course.prerequisites.delete_all

      # Create prerequisites
      course_params[:prerequisites].each do |p|
        Prerequisite.create(id: p, course_id: @course.id)
      end

      # Delete previous locations
      @course.locations.delete @course.locations

      # New location
      course_params[:locations].each do |l|
        @course.locations << Location.find(l)
      end

      # Delete previous categories
      @course.categories.delete @course.categories

      # New category
      course_params[:categories].each do |c|
        @course.categories << Category.find(c)
      end

      redirect_to courses_path, flash: { success: "Successfully updated #{@course.name} course!" }
    end
  end

  private
    def validate(course)
      # Get external params from course
      external_params = params.require(:course).permit([:prerequisites => [], :locations => [], :categories => []])

      # Clean array if it contains an empty string
      external_params.each do |k, v|
        external_params[k].clean_empty
      end

      # Validate collection first
      course.valid?

      # Add custom errors after call
      # Disabled Prerequisite since it can be optional
      # course.errors.add(:base, "Prerequisite can't be blank") if external_params[:prerequisites].empty?
      course.errors.add(:base, "Location can't be blank") if external_params[:locations].empty?
      course.errors.add(:base, "Category can't be blank") if external_params[:categories].empty?

      # Save course
      if course.errors.any?
        false
      else
        # New prerequisite
        external_params[:prerequisites].each do |p|
          # Check if location exists
          if !Course.exists?(id: p)
            # Make sure to render and return
            course.errors.add(:base, "Prerequisite does not exist")
            render 'new'
            return
          end
        end

        # New location
        external_params[:locations].each do |l|
          # Check if location exists
          if Location.exists?(id: l)
            course.locations << Location.find_by_id(l)
          else
            # Make sure to render and return
            course.errors.add(:base, "Location does not exist")
            render 'new'
            return
          end
        end

        # New category
        external_params[:categories].each do |c|
          # Check if category exists
          if Category.exists?(id: c)
            course.categories << Category.find_by_id(c)
          else
            # Make sure to render and return
            course.errors.add(:base, "Category does not exist")
            render 'new'
            return
          end
        end
      end
    end
end
