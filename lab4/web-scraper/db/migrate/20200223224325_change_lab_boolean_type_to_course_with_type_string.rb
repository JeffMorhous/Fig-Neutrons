#This migration was written to remove the "lab" column (of the courses table) and replace it with a "type" column so we could use a string
class ChangeLabBooleanTypeToCourseWithTypeString < ActiveRecord::Migration[6.0]
  #The up method is called on db:migrate (it is the forwards migration)
  def up
    remove_column :courses, :lab, :boolean
    add_column :courses, :type, :string
  end

  #The down method allows for db:rollback functionality
  def down
    add_column :courses, :lab, :boolean
    remove_column :courses, :type, :string
  end
end
