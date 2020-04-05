class DissallowSomeNullsInCourses < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:courses, :department, false )
    change_column_null(:courses, :course, false )
    change_column_null(:courses, :is_lab, false )
  end
end