class ChangeNameOfTypeToComponent < ActiveRecord::Migration[6.0]
  def change
    rename_column :courses, :type, :component
  end
end
