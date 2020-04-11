class RenameAndRetypeCourseForCourse < ActiveRecord::Migration[6.0]
  def change
    rename_column :courses, :course, :section_number
    change_column :courses, :section_number, :string
  end
end
