class CreatePrerequisites < ActiveRecord::Migration[5.0]
  def change
    create_table :prerequisites, :id => false do |t|
      t.integer :id
      t.integer :course_id
    end

    add_index :prerequisites, :id
    add_index :prerequisites, :course_id
  end
end
