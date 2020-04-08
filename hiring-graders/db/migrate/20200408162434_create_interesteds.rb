class CreateInteresteds < ActiveRecord::Migration[6.0]
  def change
    create_table :interesteds do |t|
      t.string :department
      t.string :course

      t.timestamps
    end
  end
end
