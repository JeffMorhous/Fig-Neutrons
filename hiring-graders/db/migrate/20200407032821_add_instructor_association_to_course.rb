class AddInstructorAssociationToCourse < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :instructor_id, :integer
    add_index 'courses', ['instructor_id'], :name => 'index_instructor_id'
  end
end
