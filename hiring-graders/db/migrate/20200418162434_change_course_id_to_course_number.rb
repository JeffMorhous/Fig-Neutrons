class ChangeCourseIdToCourseNumber < ActiveRecord::Migration[6.0]
  def change
    remove_column :recommendations, :course_id, :integer
    add_column :recommendations, :course_number, :string
  end
end
