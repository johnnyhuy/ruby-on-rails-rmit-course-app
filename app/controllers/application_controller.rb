class ApplicationController < ActionController::Base
  include ApplicationHelper
  include SessionsHelper

  protect_from_forgery with: :exception

  before_action :populate

  def populate
    # Location
    @locations = Location.all
    @location = Location.new

    # Cateogry
    @categories = Category.all
    @category = Category.new

    # Course
    @courses = Course.all
    @course = Course.new

    # Prereq
    @prerequisites = Prerequisite.all
  end
end
