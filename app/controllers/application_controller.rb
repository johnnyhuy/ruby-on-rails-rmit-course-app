class ApplicationController < ActionController::Base
  include SessionsHelper

  protect_from_forgery with: :exception
  before_action :populate

  def populate
    @locations = Location.all
    @categories = Category.all
  end
end
