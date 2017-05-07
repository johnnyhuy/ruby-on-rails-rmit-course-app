class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :populate_locations, :populate_categories
  include SessionsHelper

  def populate_locations
    @location_tags = Location.select(:id, :name).distinct
  end

  def populate_categories
    @category_tags = Category.select(:id, :name).distinct
  end
end
