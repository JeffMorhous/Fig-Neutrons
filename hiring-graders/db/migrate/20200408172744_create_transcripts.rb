class CreateTranscripts < ActiveRecord::Migration[6.0]
  def change
    create_table :transcripts do |t|
      t.integer :grade

      t.timestamps
    end
  end
end
