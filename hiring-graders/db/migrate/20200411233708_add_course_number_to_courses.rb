class AddCourseNumberToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :course_number, :string
  end
end
