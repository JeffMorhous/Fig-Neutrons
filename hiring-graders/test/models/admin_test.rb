require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  test 'valid admin' do
    admin = Admin.new(email: 'jeff@example.com', password: "mypassword", password_confirmation: "mypassword")
    assert admin.valid?
  end

  test 'passwords must match' do
    admin = Admin.new(email: 'jeff@example.com', password: "mypassword", password_confirmation: "notmypassword")
    refute admin.valid?, 'passwords do not match'
  end

  test 'invalid admin without email' do
    admin = Admin.new(password: 'jeffiscool', password_confirmation: "jeffiscool")
    refute admin.valid?, 'admin is valid without a email'
    assert_not_nil admin.errors[:email], 'no validation error for email present'
  end

  test 'email must be a valid format' do
    admin = Admin.new(email: 'jeffexamplecom', password: "mypassword", password_confirmation: "notmypassword")
    refute admin.valid?, 'admin is valid with an invalid email format'
    assert_not_nil admin.errors[:email], 'no validation error for email present'
  end

end
