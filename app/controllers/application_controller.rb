class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_filter :populate_locations, :populate_categories
  
  def populate_locations
    @location_tags = Location.select(:id, :name).distinct
  end

  def populate_categories
    @category_tags = Category.select(:id, :name).distinct
  end

end
