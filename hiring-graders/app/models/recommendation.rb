class Recommendation < ApplicationRecord
  has_one :student
  has_one :course
  has_one :instructor
end
