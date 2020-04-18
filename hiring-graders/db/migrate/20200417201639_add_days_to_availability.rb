class AddDaysToAvailability < ActiveRecord::Migration[6.0]
  def change
    add_column :availabilities, :day, :string
  end
end
