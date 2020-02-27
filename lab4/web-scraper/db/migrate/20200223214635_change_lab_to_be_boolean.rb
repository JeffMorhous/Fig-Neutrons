#This migration was written to change the type of the "lab" column (of the courses table) to be boolean
class ChangeLabToBeBoolean < ActiveRecord::Migration[6.0]
  #The up method is called on db:migrate (it is the forwards migration)
  def up
    change_column :courses, :lab, :boolean
  end

  #The down method allows for db:rollback functionality
  def down
    change_column :courses, :lab, :boolean
  end
end
