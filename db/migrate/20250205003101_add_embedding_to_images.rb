class AddEmbeddingToImages < ActiveRecord::Migration[8.0]
  def change
    add_column :images, :embedding, :binary
  end
end
