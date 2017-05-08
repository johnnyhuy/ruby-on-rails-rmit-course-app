class LocationsController < ApplicationController
  # Middleware
  before_action :logged_users_only, only: [:create, :new]

  def index

  end

  def new
    @location = Location.new()
  end

  def create
    new_location = params.require(:location).permit(:name)
    @location = Location.new(new_location)

    if @location.save
      redirect_to root_path, flash: { success: "Successfully created location #{@location.name}!" }
    else
      render 'new'
    end
  end

  def show
    @location = Location.find(params[:id])
    @courses = @location.courses
  end
end