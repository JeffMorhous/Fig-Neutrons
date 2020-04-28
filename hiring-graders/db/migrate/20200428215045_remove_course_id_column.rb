class RemoveCourseIdColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :previous_graders, :course_id
    add_column :previous_graders, :course_num, :string
  end
end
