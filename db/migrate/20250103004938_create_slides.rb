class CreateSlides < ActiveRecord::Migration[8.0]
  def change
    create_table :slides do |t|
      t.string :title, default: ''
      t.integer :position
      t.timestamps
    end
  end
end
