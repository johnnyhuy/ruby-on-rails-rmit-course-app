class Category < ApplicationRecord
  has_and_belongs_to_many :courses
  
  before_save :case_format
  
  validates :name,
  presence: true,
  length: {
    minimum: 1,
    maximum: 32
  },
  format: {
    with: /\A[a-zA-Z\s]+\z/
  }

  # return if there is 1 record whose name equals this instances name
  def duplicate?
      Category.where(name: self.name).count > 0
  end
    
  def case_format
      self.name = self.name.split.map(&:capitalize).join(' ')
  end
end
