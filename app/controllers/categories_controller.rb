class CategoriesController < ApplicationController
    def new
    end

    def show
      @category = Category.find(params[:id])
      @courses = @category.courses
    end
end
