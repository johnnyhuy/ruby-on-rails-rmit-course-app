class CategoriesController < ApplicationController
  # Middleware
  before_action :logged_users_only, only: [:create, :new]

  def create
    new_category = params.require(:category).permit(:name)
    @category = Category.new(new_category)

    if @category.save
      redirect_to root_path, flash: { success: 'Successfully created category. ' + @category.name }
    else
      render 'new'
    end
  end

  def new
   @category = Category.new(name: "")
 end

 def show
  @category = Category.find(params[:id])
  @courses = @category.courses
end
end
