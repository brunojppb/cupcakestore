require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(first_name: "First Name", 
                      last_name: "Last Name", 
                      email: "user@user.com",
                      password: "foobar",
                      password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "First Name should be present" do
    @user.first_name = "          "
    assert_not @user.valid?
  end

  test "Last Name should be present" do
    @user.last_name = "          "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "       "
    assert_not @user.valid?
  end

  test "First Name sould not be too long" do
    @user.first_name = "a" * 100
    assert_not @user.valid?
  end

  test "Last Name sould not be too long" do
    @user.last_name = "a" * 100
    assert_not @user.valid?
  end

  test "Email sould not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "Email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@FOO.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email address should be unique" do
    user_copy = @user.dup
    user_copy.email = @user.email.upcase
    @user.save
    assert_not user_copy.valid?
  end

  test "Password should have a minimum 6 characters of length" do
    @user.password = @user.password_confirmation = "a" * 5;
    assert_not @user.valid?
  end


end
