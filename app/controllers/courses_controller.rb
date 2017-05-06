class CoursesController < ApplicationController
  include CoursesHelper
  
  def create
    render plain: params[:course].inspect
  end

  def index
    @courses = list
  end

  def new

  end
  
  def show
  end
end
