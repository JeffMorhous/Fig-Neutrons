class ChangeInstructorType < ActiveRecord::Migration[6.0]
  def change
    change_column :courses, :instructor, :string
  end
end
