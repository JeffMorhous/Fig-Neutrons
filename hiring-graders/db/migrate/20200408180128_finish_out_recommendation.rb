class FinishOutRecommendation < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:recommendations, :request, false )
    change_column :recommendations, :request, :boolean, default: false

    add_column :recommendations, :student_id, :integer
    add_index 'recommendations', ['student_id'], :name => 'index_recommendations_student_id'

    add_column :recommendations, :course_id, :integer
    add_index 'recommendations', ['course_id'], :name => 'index_recommendations_course_id'

    add_column :recommendations, :instructor_id, :integer
    add_index 'recommendations', ['instructor_id'], :name => 'index_recommendations_instructor_id'
  end
end
