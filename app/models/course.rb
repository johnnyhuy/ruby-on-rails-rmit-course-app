class Course < ApplicationRecord
  # Categories
  has_and_belongs_to_many :categories, :dependant => :destroy

  # Locations
  has_and_belongs_to_many :locations, :dependant => :destroy

  # Prerequisites
  has_and_belongs_to_many :prerequisites, :dependant => :destroy

  # Likes
  has_many :likes
  has_many :users, through: :likes

  # Dislikes
  has_many :dislikes
  has_many :users, through: :dislikes

  mount_uploader :image, CourseUploader

  validates :name,
    presence: true,
    length: {
      minimum: 2,
      maximum: 32
    },
    format: {
      with: /\A[\w\s\d]+\z/i,
      message: 'is invalid, must only contain alpha-numeric characters.'
    },
    uniqueness: {
      case_sensitive: false
    }
  validates :description,
    presence: true,
    length: {
      minimum: 30,
      maximum: 1024
    }
end
