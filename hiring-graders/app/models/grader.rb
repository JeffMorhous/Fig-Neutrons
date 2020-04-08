class Grader < ApplicationRecord
  has_one :student
  has_one :section
end
