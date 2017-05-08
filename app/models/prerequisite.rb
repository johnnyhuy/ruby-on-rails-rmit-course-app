class Prerequisite < ApplicationRecord
  belongs_to :course

  # Get the prerequisite name
  # Not to confuse with the course_id name
  def name
    Course.find_by_id(self.id).name
  end
end
