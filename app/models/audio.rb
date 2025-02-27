class Audio < ApplicationRecord
  has_one_attached :file

  after_create_commit -> { transcript and process and broadcast }

  def transcript
    return unless file.attachment.present?

    if file.attached?
      file.open do |file|
        response = OpenAIClient.audio.translate(
          parameters: {
            model: "whisper-1",
            file: file
          }
        )
        self.transcription = response["text"]

        save
      end
    end
  end

  def process
    response = OpenAIClient.chat(
      parameters: {
        model: "gpt-4o",
        messages: [ { "role": "user", "content": transcription } ],
        tools: [
          {
            type: "function",
            function: {
              name: "iDontUnderstand",
              description: "A default function that is called when the assistant doesn't understand the user's input.",
              parameters: {
                type: :object,
                properties: {
                  comment: {
                    type: :string,
                    description: "The description of the best guess of what the user meant."
                  }
                },
                required: [ "comment" ]
              }
            }
          },
          {
            type: "function",
            function: {
              name: "moveTo",
              description: "Move to a given section of the screen.",
              parameters: {
                type: :object,
                properties: {
                  x: {
                    type: :number,
                    description: "The x-coordinate of the location, ranging from -1 to 1, where -1 is the left, 1 is the right, 0 is the center."
                  }
                },
                required: [ "x" ]
              }
            }
          },
          {
            type: "function",
            function: {
              name: "come_to_us",
              description: "Orders the dog called Gem to come to us, ",
              parameters: {}
            }
          },
          {
            type: "function",
            function: {
              name: "sniff",
              description: "Sniff around",
              parameters: {}
            }
          },
          {
            type: "function",
            function: {
              name: "givePaw",
              description: "Give a paw",
              parameters: {}
            }
          },
          {
            type: "function",
            function: {
              name: "jump",
              description: "Jump up",
              parameters: {}
            }
          },
          {
            type: "function",
            function: {
              name: "largerFont",
              description: "Make the font larger",
              parameters: {}
            }
          },
          {
            type: "function",
            function: {
              name: "smallerFont",
              description: "Make the font smaller",
              parameters: {}
            }
          },
          {
            type: "function",
            function: {
              name: "darkMode",
              description: "Enable Dark Mode",
              parameters: {}
            }
          },
          {
            type: "function",
            function: {
              name: "find_image",
              description: "Finds images matching given description",
              parameters: {
                type: :object,
                properties: {
                  image_description: {
                    type: :string,
                    description: "description of the searched image"
                  }
                },
                required: [ "image_description" ]
              }
            }
          },
          {
            type: "function",
            function: {
              name: "find_laptop",
              description: "Finds laptop or notebook by choosing parameters matching the search criteria.",
              parameters: {
                type: :object,
                properties: {
                  screen_diagonal: {
                    type: :number,
                    enum: [ 13, 15, 16, 20 ],
                    description: "The diagonal of a searched notebook screen expressed in inches."
                  },
                  price_min: {
                    type: :number,
                    description: "The minimal price of a searched notebook, expressed in dollars."
                  },
                  price_max: {
                    type: :number,
                    description: "The maximal price of a searched notebook, expressed in dollars."
                  },
                  hard_drive_size: {
                    type: :number,
                    enum: [ 256, 512, 1024, 2048 ],
                    description: "The size of harddrive expressed in gigabytes."
                  },
                  available_only: {
                    type: :boolean,
                    description: "Whether the search should include only notebooks which are available (in stock)"
                  },
                  ram_size: {
                    type: :number,
                    enum: [ 8, 16, 32, 48 ],
                    description: "The size of RAM included in the notebook, expressed in Gigabytes"
                  }
                },
                required: [ "screen_diagonal" ]
              }
            }
          }
        ]
      }
    )
    self.command = "none"

    message = response.dig("choices", 0, "message")

    if message["role"] == "assistant"
      self.assistant_message = message["content"]

      if message["tool_calls"]
        tool_call = message["tool_calls"].first

        self.command = tool_call.dig("function", "name")
        self.command_params = JSON.parse(tool_call.dig("function", "arguments"), symbolize_names: true)
      end
    end

    save
  end

  def broadcast
    Turbo::StreamsChannel.broadcast_append_to(
      "audios",
      target: "audios",
      partial: "audios/audio",
      locals: {
        audio: self
      }
    )
  end
end
