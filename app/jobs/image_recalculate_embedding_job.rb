# app/jobs/my_job.rb

class ImageRecalculateEmbeddingJob < ApplicationJob
  def perform(image_id)
    image = Image.find(image_id)

    image.recalculate_embedding
  end
end
