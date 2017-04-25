class User < ApplicationRecord
  before_save {
    self.email = email.downcase
  }

  # Validation rules
  validates :name,
    presence: true,
    length: {
      minimum: 2,
      maximum: 32
    }
  validates :email,
    presence: true,
    length: {
      minimum: 2,
      maximum: 255
    },
    format: {
      with: /\A([\w+\-].?)+@[A-z\d\-]+(\.[A-z]+)*\.[A-z]+\z/i
    },
    uniqueness: {
      case_sensitive: false
    }
  validates :password,
    presence: true,
    length: {
      minimum: 6,
      maximum: 32
    },
    format: {
      with: /\A[A-Z]+[0-9]+[a-z]+\z/
    }

  has_secure_password
end
