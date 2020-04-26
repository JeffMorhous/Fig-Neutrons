class Evaluation < ApplicationRecord
  belongs_to :course
  belongs_to :student
  belongs_to :instructor
end
