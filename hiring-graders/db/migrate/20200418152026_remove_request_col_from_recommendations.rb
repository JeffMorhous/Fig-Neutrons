class RemoveRequestColFromRecommendations < ActiveRecord::Migration[6.0]
  def change
    remove_column :recommendations, :request
  end
end
