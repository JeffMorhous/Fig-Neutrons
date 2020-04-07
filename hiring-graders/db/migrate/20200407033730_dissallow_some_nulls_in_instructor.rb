class DissallowSomeNullsInInstructor < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:instructors, :first_name, false )
    change_column_null(:instructors, :last_name, false )
  end
end
