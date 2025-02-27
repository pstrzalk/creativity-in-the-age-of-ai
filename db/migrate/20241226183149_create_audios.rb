class CreateAudios < ActiveRecord::Migration[8.0]
  def change
    create_table :audios do |t|
      t.timestamps
    end
  end
end
