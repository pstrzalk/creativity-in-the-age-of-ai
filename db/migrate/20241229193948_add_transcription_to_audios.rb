class AddTranscriptionToAudios < ActiveRecord::Migration[8.0]
  def change
    add_column :audios, :transcription, :text
  end
end
