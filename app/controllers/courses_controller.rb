class CoursesController < ApplicationController
  
  def create
    render plain: params[:course].inspect
  end

  def index
    @reminder_id = params[:id] || "*"
    @reminder_cat = params[:table] || "Courses" 
    @courses = Course.all
  end

  def new

  end
  
  def show
  end
end
