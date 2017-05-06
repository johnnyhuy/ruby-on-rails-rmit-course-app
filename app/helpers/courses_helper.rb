module CoursesHelper
    
    def list
        id = params[:id]
        table = params[:table]
        
        if !id.present?
            return Course.all
            
        elsif table == "Location"
            @query = "INNER JOIN courses_locations cl
                ON courses.id = cl.course_id
                INNER JOIN locations l
                ON cl.location_id = l.id
                WHERE l.id = "
                
        elsif table == "Category"
            @query = "Inner JOIN categories_courses cc
                ON courses.id = cc.course_id
                INNER JOIN categories c
                ON cc.category_id = c.id
                WHERE c.id = "
        end
        @query << id
        @ordered_list = Course.joins(@query)
    end
end
