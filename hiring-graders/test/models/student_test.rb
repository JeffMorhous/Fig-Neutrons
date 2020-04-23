require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  test 'valid student' do
    student = Student.new(first_name: "Jeff", last_name: "Morhous", email: 'jeff@example.com', password: "mypassword", password_confirmation: "mypassword")
    assert student.valid?
  end

  test 'passwords must match' do
    student = Student.new(first_name: "Jeff", last_name: "Morhous", email: 'jeff@example.com', password: "mypassword", password_confirmation: "notmypassword")
    refute student.valid?, 'passwords do not match'
  end

  test 'invalid student without email' do
    student = Student.new(first_name: "Jeff", last_name: "Morhous", password: 'jeffiscool', password_confirmation: "jeffiscool")
    refute student.valid?, 'student is valid without a email'
    assert_not_nil student.errors[:email], 'no validation error for email present'
  end

  test 'invalid student without first name' do
    student = Student.new(last_name: "Morhous", password: 'jeffiscool', password_confirmation: "jeffiscool")
    refute student.valid?, 'student is valid without a first name'
    assert_not_nil student.errors[:first_name], 'no validation error for first name present'
  end

  test 'invalid student without last_name' do
    student = Student.new(first_name: "Jeff", password: 'jeffiscool', password_confirmation: "jeffiscool")
    refute student.valid?, 'student is valid without a last name'
    assert_not_nil student.errors[:last_name], 'no validation error for last name present'
  end

  test 'email must be a valid format' do
    student = Student.new(first_name: "Jeff", last_name: "Morhous", email: 'jeffexamplecom', password: "mypassword", password_confirmation: "notmypassword")
    refute student.valid?, 'student is valid with an invalid email format'
    assert_not_nil student.errors[:email], 'no validation error for email present'
  end
end
