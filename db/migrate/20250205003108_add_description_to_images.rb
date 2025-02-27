class AddDescriptionToImages < ActiveRecord::Migration[8.0]
  def change
    add_column :images, :description, :text
  end
end
