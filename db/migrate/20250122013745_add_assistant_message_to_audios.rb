class AddAssistantMessageToAudios < ActiveRecord::Migration[8.0]
  def change
    add_column :audios, :assistant_message, :text, default: ''
  end
end
