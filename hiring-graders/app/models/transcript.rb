class Transcript < ApplicationRecord
  has_one :student
  has_one :course
end
