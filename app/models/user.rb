class User < ApplicationRecord
  has_secure_password
  before_save :downcase_fields

  # Validation rules
  validates :name,
    presence: true,
    length: {
      minimum: 2,
      maximum: 32
    },
    format: {
      with: /\A[a-zA-Z\s]+\z/
    }
  validates :email,
    presence: true,
    length: {
      minimum: 2,
      maximum: 255
    },
    format: {
      with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
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
      with: /\A^(?=.*[A-Z])(?=.*[\d])[\S]*/,
      message: 'is invalid (must contain an uppercase letter and a number)'
    }

  def downcase_fields
    self.email.downcase!
  end
end
