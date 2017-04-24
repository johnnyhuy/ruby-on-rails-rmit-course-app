class CoursesController < ApplicationController
  def create
    render plain: params[:course].inspect
  end

  def index
    @courses = Course.all
  end

  def new

  end
end
