require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "should be valid" do
    test_user = User.new(name: "Example User", email: "user@example.com")
    assert test_user.valid?
  end

  test "name should be present" do
    test_user = User.new(name: "      ", email: "user@example.com")
    assert_not test_user.valid?
  end

  test "name should be less than 50 characters" do
    test_user = User.new(name: ("a" * 51), email: "user@example.com")
    assert_not test_user.valid?
  end

  test "email should be present" do
    test_user = User.new(name: "Example User", email: "       ")
    assert_not test_user.valid?
  end

  test "email should be not greater than 255 characters" do
    test_user = User.new(name: "Example User", email: "a" * 256)
    assert_not test_user.valid?
  end

  test "email should be valid" do
    test_user = User.new(name: "Example User")
    valid_addresses = %w[user@example.com USER@foo.COM first.last@foo.jp A_US-ER@foo.bar.com]
    valid_addresses.each do |valid_address|
      test_user.email = valid_address
      assert test_user.valid?, "Address #{valid_address} should be valid"
    end
  end

  test "email should not be valid" do
    test_user = User.new(name: "Example User")
    valid_addresses = %w[user@example,com USER_at_foo.COM first.last@foo.jp@bar A_US-ER@foo+bar.com]
    valid_addresses.each do |not_valid_address|
      test_user.email = not_valid_address
      assert_not test_user.valid?, "Address #{not_valid_address} should not be valid"
    end
  end

  test "email addresses should be unique" do
    test_user = User.new(name: "Example User", email: "user@example.com")
    duplicate_user = test_user.dup
    duplicate_user.email = test_user.email.upcase
    test_user.save
    assert_not duplicate_user.valid?
  end
end
