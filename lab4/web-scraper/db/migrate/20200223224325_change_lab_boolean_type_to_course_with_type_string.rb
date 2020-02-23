class ChangeLabBooleanTypeToCourseWithTypeString < ActiveRecord::Migration[6.0]
  def up
    remove_column :courses, :lab, :boolean
    add_column :courses, :type, :string
  end

  def down
    add_column :courses, :lab, :boolean
    remove_column :courses, :type, :string
  end
end
