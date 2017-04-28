class CoursesController < ApplicationController
  
  def create
    render plain: params[:course].inspect
  end

  def index
    @courses = Course.all
  end

  def list
    @courses = Course.all
  end
  
  def show
    #@course = Course.find(params[:id])
    @courses = list
  end

  def new

  end
end
