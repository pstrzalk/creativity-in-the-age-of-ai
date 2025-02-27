class AddImages < ActiveRecord::Migration[8.0]
  def change
    create_table :images do |t|
      t.timestamps
    end
  end
end
