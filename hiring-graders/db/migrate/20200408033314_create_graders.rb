class CreateGraders < ActiveRecord::Migration[6.0]
  def change
    create_table :graders do |t|
      t.string :semester

      t.timestamps
    end
  end
end
