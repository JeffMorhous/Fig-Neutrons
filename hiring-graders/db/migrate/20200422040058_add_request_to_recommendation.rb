class AddRequestToRecommendation < ActiveRecord::Migration[6.0]
  def change
    add_column :recommendations, :request, :boolean

  end
end
