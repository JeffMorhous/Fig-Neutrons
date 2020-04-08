class FinishInteresteds < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:interesteds, :department, false )
    change_column_null(:interesteds, :course, false )
  end
end
