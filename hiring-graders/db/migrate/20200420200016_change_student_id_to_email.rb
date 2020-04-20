class ChangeStudentIdToEmail < ActiveRecord::Migration[6.0]
  def change
    remove_index :recommendations, name: :index_recommendations_student_id
    rename_column :recommendations, :student_id, :student_email
  end
end
