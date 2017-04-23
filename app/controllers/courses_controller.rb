class CoursesController < ApplicationController
  def new
  end

  def create
    render plain: params[:course].inspect
  end
end
