class CreateSlideParts < ActiveRecord::Migration[8.0]
  def change
    create_table :parts do |t|
      t.references :slide, null: false, foreign_key: true

      t.integer :position
      t.string :part_type
      t.string :contents
      t.timestamps
    end
  end
end
