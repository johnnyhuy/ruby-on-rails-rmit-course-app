class Course < ApplicationRecord
  # Categories
  has_and_belongs_to_many :categories

  # Locations
  has_and_belongs_to_many :locations

  # Prerequisites
  has_many :prerequisites

  # Likes
  has_many :likes
  has_many :users, through: :likes

  # Dislikes
  has_many :dislikes
  has_many :users, through: :dislikes

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
