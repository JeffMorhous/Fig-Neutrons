class CreateEvaluations < ActiveRecord::Migration[6.0]
  def change
    create_table :evaluations do |t|
      t.references :course, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
      t.references :instructor, null: false, foreign_key: true
      t.integer :quality
      t.integer :punctuality
      t.integer :com_skills
      t.integer :course_knowledge

      t.timestamps
    end
  end
end
