class CoursesController < ApplicationController
  include CoursesHelper

  # Middleware
  before_action :logged_users_only, except: [:index, :show]

  def create
    render plain: params[:course].inspect
  end

  def index
    @courses = list
  end

  def new

  end

  def show
    @course = Course.find(params[:id])
  end
end
