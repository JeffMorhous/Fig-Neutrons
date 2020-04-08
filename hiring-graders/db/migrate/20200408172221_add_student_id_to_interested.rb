class AddStudentIdToInterested < ActiveRecord::Migration[6.0]
  def change
    add_column :interesteds, :student_id, :integer
    add_index 'interesteds', ['student_id'], :name => 'index_interested_student_id'
  end
end
