require 'test_helper'

class InstructorTest < ActiveSupport::TestCase
  test 'valid instructor' do
    instructor = Instructor.new(first_name: "Jeff", last_name: "Morhous", email: 'jeff@example.com', password: "mypassword", password_confirmation: "mypassword")
    assert instructor.valid?
  end

  test 'passwords must match' do
    instructor = Instructor.new(first_name: "Jeff", last_name: "Morhous", email: 'jeff@example.com', password: "mypassword", password_confirmation: "notmypassword")
    refute instructor.valid?, 'passwords do not match'
  end

  test 'invalid instructor without email' do
    instructor = Instructor.new(first_name: "Jeff", last_name: "Morhous", password: 'jeffiscool', password_confirmation: "jeffiscool")
    refute instructor.valid?, 'instructor is valid without a email'
    assert_not_nil instructor.errors[:email], 'no validation error for email present'
  end

  test 'invalid instructor without first name' do
    instructor = Instructor.new(last_name: "Morhous", password: 'jeffiscool', password_confirmation: "jeffiscool")
    refute instructor.valid?, 'instructor is valid without a first name'
    assert_not_nil instructor.errors[:first_name], 'no validation error for first name present'
  end

  test 'invalid instructor without last_name' do
    instructor = Instructor.new(first_name: "Jeff", password: 'jeffiscool', password_confirmation: "jeffiscool")
    refute instructor.valid?, 'instructor is valid without a last name'
    assert_not_nil instructor.errors[:last_name], 'no validation error for last name present'
  end

  test 'email must be a valid format' do
    instructor = Instructor.new(first_name: "Jeff", last_name: "Morhous", email: 'jeffexamplecom', password: "mypassword", password_confirmation: "notmypassword")
    refute instructor.valid?, 'instructor is valid with an invalid email format'
    assert_not_nil instructor.errors[:email], 'no validation error for email present'
  end
end
