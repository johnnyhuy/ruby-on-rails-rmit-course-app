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
    length: {
      minimum: 8,
      maximum: 32
    },
    format: {
      with: /\A^(?=.*[A-Z])(?=.*[\d])(?=.*[a-z])[\S]*/,
      message: 'is invalid (must contain an uppercase letter and a number)'
    }
  validates :password_confirmation,
    presence: true

  def downcase_fields
    self.email.downcase!
  end

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
