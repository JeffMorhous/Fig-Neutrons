class FinishOutTranscripts < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:transcripts, :grade, false )

    add_column :transcripts, :student_id, :integer
    add_index 'transcripts', ['student_id'], :name => 'index_transcript_student_id'

    add_column :transcripts, :course_id, :integer
    add_index 'transcripts', ['course_id'], :name => 'index_transcript_course_id'
  end
end
