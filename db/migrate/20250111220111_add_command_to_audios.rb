class AddCommandToAudios < ActiveRecord::Migration[8.0]
  def change
    add_column :audios, :command, :string, default: ''
    add_column :audios, :command_params, :jsonb, default: {}
  end
end
