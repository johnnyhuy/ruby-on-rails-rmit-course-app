class ApplicationController < ActionController::Base
  include SessionsHelper

  protect_from_forgery with: :exception
  before_action :populate_locations, :populate_categories

  def populate_locations
    @location_tags = Location.select(:id, :name).distinct
  end

  def populate_categories
    @category_tags = Category.select(:id, :name).distinct
  end
end
