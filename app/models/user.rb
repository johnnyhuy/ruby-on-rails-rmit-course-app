class User < ApplicationRecord
  # Public accessors e.g. User.remember_token
  attr_accessor :remember_token

  # Call secure password method
  has_secure_password

  # Call certain methods before saving to db
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
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Create a remember token
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    # Check if remember_digest in db exists
    return false if remember_digest.nil?

    # is_password method matches the two tokens (db and arg)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
end
