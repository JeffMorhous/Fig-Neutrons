class AddDefaultValueToBooleans < ActiveRecord::Migration[6.0]
  def change
    def up
      change_column :courses, :need_grader, :boolean, default: false
      change_column :courses, :have_grader, :boolean, default: false
    end

    def down
      change_column :courses, :need_grader, :boolean, default: nil
      change_column :courses, :have_grader, :boolean, default: nil
    end
  end
end
