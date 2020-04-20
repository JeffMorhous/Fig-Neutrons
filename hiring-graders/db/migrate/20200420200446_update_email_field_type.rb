class UpdateEmailFieldType < ActiveRecord::Migration[6.0]
  def change
    change_column :recommendations, :student_email, :string

  end
end
