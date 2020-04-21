class ChangeNeedGraderDefaultValue < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:courses, :need_grader, true)
  end
end
