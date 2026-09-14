require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @valid_attributes = {
      email: "test@example.com",
      password: "password",
      first_name: "John",
      last_name: "Doe"
    }
  end

  test "should be valid with valid attributes" do
    user = User.new(@valid_attributes)
    assert user.valid?
  end

  test "should not be valid without an email" do
    user = User.new(@valid_attributes.except(:email))
    assert_not user.valid?
  end

  test "should not be valid without a password" do
    user = User.new(@valid_attributes.except(:password))
    assert_not user.valid?
  end

  test "should not be valid without a first name" do
    user = User.new(@valid_attributes.except(:first_name))
    assert_not user.valid?
  end

  test "should not be valid with a short password" do
    user = User.new(@valid_attributes.merge(password: "1234567"))
    assert_not user.valid?
  end

  test "should not be valid with a duplicate email" do
    User.create!(@valid_attributes)
    duplicate = User.new(@valid_attributes.merge(first_name: "Jane"))
    assert_not duplicate.valid?
  end

  test "should return full name" do
    user = User.new(@valid_attributes)
    assert_equal "John Doe", user.full_name
  end
end
