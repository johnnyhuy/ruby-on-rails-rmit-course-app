ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Check if user is logged in
  # Use this method instead of SessionHelper
  def logged_in_session?
    !session[:user_id].nil?
  end


  # Login as a user
  def login_as(user)
    session[:user_id] = user.id
  end

  # Add more helper methods to be used by all tests here...
  include SessionsHelper
end

class ActionDispatch::IntegrationTest
  # Login
  def login_as(user, password: 'Password123', remember_me: '1')
    post login_path, params: {
      session: {
        email: user.email,
        password: user.password,
        remember_me: remember_me
      }
    }
  end
end