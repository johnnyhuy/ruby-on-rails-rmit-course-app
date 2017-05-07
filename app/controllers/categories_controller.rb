class CategoriesController < ApplicationController
    def create
        new_category = params.require(:category).permit(:name)
        @category = Category.new(new_category)
        
        
        if !@category.valid?
            flash[:danger] = "Error the category name is not valid"
            render 'new'
        elsif @category.duplicate?
            flash[:danger] = "The category name already exists!"
            render 'new'
        else
            @category.save
            redirect_to root_path, flash: 
            { success: 'Successfully created category. ' + @category.name }
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
