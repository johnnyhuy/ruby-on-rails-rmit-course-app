class CreateCoursesPrerequisitesAndLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :prerequisite
      t.text :description

      t.timestamps
    end

    create_table :prerequisites do |t|
      t.string :name

      t.timestamps
    end

    create_table :locations do |t|
      t.string :name

      t.timestamps
    end

    create_join_table :courses, :prerequisites do |t|
      t.index :course_id
      t.index :prerequisite_id
    end

    create_join_table :courses, :locations do |t|
      t.index :course_id
      t.index :location_id
    end
  end
end
