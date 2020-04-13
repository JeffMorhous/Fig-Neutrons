class ChangeCourseTimeType < ActiveRecord::Migration[6.0]
  def change
    change_column :courses, :start_time, :string
    change_column :courses, :end_time, :string
  end
end
