class CreatePreviousGraders < ActiveRecord::Migration[6.0]
  def change
    create_table :previous_graders do |t|
      t.references :student
      t.references :course

      t.timestamps
    end
  end
end
