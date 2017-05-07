class Location < ApplicationRecord
  has_and_belongs_to_many :courses
  
  validates :name,
  presence: true,
  length: {
    minimum: 10,
    maximum: 10
  },
  format: {
    with: /\A\d{1,3}.\d{1,2}.{1,4}\z/
  }
  
  def duplicate?
      Location.where(name: self.name).count > 0
  end
  
end
