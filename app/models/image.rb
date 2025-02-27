class Image < ApplicationRecord
  has_one_attached :file

  has_neighbors :embedding
  after_create_commit :broadcast
  after_create_commit -> { ImageRecalculateEmbeddingJob.perform_later(id) }

  def broadcast
    Turbo::StreamsChannel.broadcast_append_later_to(
      "images",
      target: "images",
      partial: "images/image",
      locals: {
        image: self
      }
    )
  end

  def recalculate_embedding
    return unless file.attachment.present?

    base64_encoded_image = Base64.strict_encode64(file.download)

    messages = [
      { "type": "text", "text": "What’s in this image? Do not identify people, just describe them and their surroundings. If possible - include gender, clothing and color description." },
      { "type": "image_url",
        "image_url": {
          "url": "data:image/png;base64,#{base64_encoded_image}"
        }
      }
    ]

    response = OpenAIClient.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [ { role: "user", content: messages } ]
      }
    )

    self.description = response.dig("choices", 0, "message", "content")

    response = OpenAIClient.embeddings(
      parameters: {
        model: "text-embedding-3-large",
        input: description
      }
    )
    self.embedding = response.dig("data", 0, "embedding")
    self.save
  end
end
