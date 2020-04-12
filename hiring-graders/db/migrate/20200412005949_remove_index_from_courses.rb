class RemoveIndexFromCourses < ActiveRecord::Migration[6.0]
  def change
    remove_index :courses, name: :index_instructor_id
    rename_column :courses, :instructor_id, :instructor
  end
end