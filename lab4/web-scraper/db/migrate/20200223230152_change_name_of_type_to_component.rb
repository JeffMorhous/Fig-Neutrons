#This migration was written to change the name of the "type" column of the  "courses" table to "component"
class ChangeNameOfTypeToComponent < ActiveRecord::Migration[6.0]
  def change
    rename_column :courses, :type, :component
  end
end
