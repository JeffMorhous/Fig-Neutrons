class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :department
      t.integer :course
      t.boolean :is_lab
      t.string :days
      t.time :start_time
      t.time :end_time
      t.string :location
      t.boolean :need_grader
      t.boolean :have_grader

      t.timestamps
    end
  end
end
