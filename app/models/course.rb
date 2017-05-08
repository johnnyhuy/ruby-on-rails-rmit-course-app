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
end
