Rails.application.config.after_initialize do
  OpenAIClient = OpenAI::Client.new(
    access_token: Rails.configuration.x.openai_api_key
  )
end
