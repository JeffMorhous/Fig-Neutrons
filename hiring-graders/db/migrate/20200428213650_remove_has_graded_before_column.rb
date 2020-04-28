class RemoveHasGradedBeforeColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :students, :has_graded_before
  end
end
