class AddDefaultToHasGradedBefore < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:students, :has_graded_before, false )
  end
end
