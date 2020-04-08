class CreateRecommendations < ActiveRecord::Migration[6.0]
  def change
    create_table :recommendations do |t|
      t.boolean :request
      t.string :recommendation

      t.timestamps
    end
  end
end
