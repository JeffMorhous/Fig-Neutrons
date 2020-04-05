class AddDefaultValueToBooleansAgain < ActiveRecord::Migration[6.0]
  def up
    change_column_default :courses, :need_grader, false
    change_column_default :courses, :have_grader, false

  end

  def down
    change_column_default :courses, :need_grader, nil
    change_column_default :courses, :have_grader, nil

  end
end
