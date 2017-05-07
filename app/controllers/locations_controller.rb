class LocationsController < ApplicationController
    def new
    end

    def show
      @location = Location.find(params[:id])
      @courses = @location.courses
    end
end