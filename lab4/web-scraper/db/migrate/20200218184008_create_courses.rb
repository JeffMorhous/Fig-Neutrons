class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.integer :number
      t.string :title
      t.string :lab
      t.string :location
      t.string :instructor
      t.string :time

      t.timestamps
    end
  end
end
