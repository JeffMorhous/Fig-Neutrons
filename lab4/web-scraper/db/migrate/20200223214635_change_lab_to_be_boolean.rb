class ChangeLabToBeBoolean < ActiveRecord::Migration[6.0]
  def up
    change_column :courses, :lab, :boolean
  end

  def down
    change_column :courses, :lab, :boolean
  end
end
