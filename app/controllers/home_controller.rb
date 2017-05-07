class HomeController < ApplicationController
  def index
    Location.delete(5)
  end
end
