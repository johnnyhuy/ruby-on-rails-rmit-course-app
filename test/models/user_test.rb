require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      name: 'Test User',
      email: 'user@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    )
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = ' '
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 64
    assert_not @user.valid?
  end

  test 'name should not be too short' do
    @user.name = 'a'
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = ' '
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = 'a' * 255 + '@email.com'
    assert_not @user.valid?
  end

  test 'email should not be too short' do
    @user.email = 'a'
    assert_not @user.valid?
  end

  test 'email is invalid' do
    @user.email = 'aaa@aa.C@m'
    assert_not @user.valid?
  end

  test 'email addresses should be unique' do
    duplicate_user = User.new(name: 'Test User', email: @user.email)
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'email is lowercase' do
    @user.email = 'ABC@EXAMPLE.COM'
    @user.save
    assert @user.email == 'abc@example.com'
  end

  test 'password should be present' do
    @user.password = ' '
    assert_not @user.valid?
  end

  test 'password should be at least 6 characters' do
    @user.password = 'a' * 5
    assert_not @user.valid?
  end

  test 'password should be less than 32 characters' do
    @user.password = 'a' * 64
    assert_not @user.valid?
  end

  test 'password must contain at least one uppercase letter' do
    @user.password = 'password'
    assert_not @user.valid?

    @user.password = 'Password123'
    assert @user.valid?
  end
end