class AddGraderAssociations < ActiveRecord::Migration[6.0]
  def change
    add_column :graders, :student_id, :integer
    add_index 'graders', ['student_id'], :name => 'index_student_id'

    add_column :graders, :course_id, :integer
    add_index 'graders', ['course_id'], :name => 'index_course_id'
  end
end
