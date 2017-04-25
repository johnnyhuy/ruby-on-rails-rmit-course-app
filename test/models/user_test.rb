require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    # Ideal user
    @user = User.new(
      name: 'Test User',
      email: 'user@example.com',
      password: 'Password123',
      password_confirmation: 'Password123'
    )
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = ' '
    assert_not @user.valid?
    assert @user.errors.messages[:name].include? 'can\'t be blank'
  end

  test 'name should not be too long' do
    @user.name = 'a' * 64
    assert_not @user.valid?
    assert @user.errors.messages[:name].include? 'is too long (maximum is 32 characters)'
  end

  test 'name should not be too short' do
    @user.name = 'a'
    assert_not @user.valid?
    assert @user.errors.messages[:name].include? 'is too short (minimum is 2 characters)'
  end

  test 'email should be present' do
    @user.email = ' '
    assert_not @user.valid?
    assert @user.errors.messages[:email].include? 'can\'t be blank'
  end

  test 'email should not be too long' do
    @user.email = 'a' * 255 + '@email.com'
    assert_not @user.valid?
    assert @user.errors.messages[:email].include? 'is too long (maximum is 255 characters)'
  end

  test 'email should not be too short' do
    @user.email = 'a'
    assert_not @user.valid?
    assert @user.errors.messages[:email].include? 'is too short (minimum is 2 characters)'
  end

  test 'email is invalid' do
    @user.email = 'aaa@aa.C@m'
    assert_not @user.valid?
  end

  test 'email addresses should be unique' do
    duplicate_user = User.new(name: 'Test User', email: @user.email)
    @user.save
    assert_not duplicate_user.valid?
    assert duplicate_user.errors.messages[:email].include? 'has already been taken'
  end

  test 'email is lowercase' do
    @user.email = 'ABC@EXAMPLE.COM'
    @user.save
    assert @user.email == 'abc@example.com'
  end

  test 'password should be present' do
    @user.password = ' '
    @user.password_confirmation = ' '
    assert_not @user.valid?
    assert @user.errors.messages[:password].include? 'can\'t be blank'
  end

  test 'password should be at least 6 characters' do
    @user.password = 'a' * 5
    assert_not @user.valid?
    assert @user.errors.messages[:password].include? 'is too short (minimum is 6 characters)'
  end

  test 'password should be less than 32 characters' do
    @user.password = 'a' * 64
    assert_not @user.valid?
    assert @user.errors.messages[:password].include? 'is too long (maximum is 32 characters)'
  end

  test 'password must contain at least one uppercase letter' do
    @user.password = 'password123'
    assert_not @user.valid?
    assert @user.errors.messages[:password].include? 'is invalid (must contain an uppercase letter and a number)'

    @user.password = 'p223ssword223'
    assert_not @user.valid?
    assert @user.errors.messages[:password].include? 'is invalid (must contain an uppercase letter and a number)'

    @user.password = 'passwoRd123'
    @user.password_confirmation = @user.password
    assert @user.valid?

    @user.password = '123passwoRD'
    @user.password_confirmation = @user.password
    assert @user.valid?

    @user.password = 'pa@@###wordD123'
    @user.password_confirmation = @user.password
    assert @user.valid?

    @user.password = 'PASSWORD332211!@#$%^&*'
    @user.password_confirmation = @user.password
    assert @user.valid?
  end

  test 'password must contain at least one number' do
    @user.password = 'Password'
    assert_not @user.valid?

    @user.password = 'P@@@@ssword'
    assert_not @user.valid?
    assert @user.errors.messages[:password].include? 'is invalid (must contain an uppercase letter and a number)'
  end

  test 'password confirmation should be present' do
    @user.password_confirmation = ''
    assert_not @user.valid?
    assert @user.errors.messages[:password_confirmation].include? 'doesn\'t match Password'
  end
end