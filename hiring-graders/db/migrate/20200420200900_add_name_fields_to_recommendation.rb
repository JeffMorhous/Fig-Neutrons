class AddNameFieldsToRecommendation < ActiveRecord::Migration[6.0]
  def change
    add_column :recommendations, :first_name, :string
    add_column :recommendations, :last_name, :string


  end
end
