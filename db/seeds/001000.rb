slide = Slide.create!
slide.parts.create!(
  part_type: 'headline',
  contents: 'Until<br />Large Language Models<br />came...'
)

slide = Slide.create!(title: 'Large Language Model')
slide.parts.create!(
  part_type: 'list',
  contents: '
  <li>LLM</li>
  <li>a machine learning model which can <span class="font-bold">process</span> and <span class="font-bold">generate human language text</span></li>
  <li>for example GPT-4, BERT, LLAMA 3.3, DeepSeek-R1 (and many more)</li>
  <li>are typically available via an API that operates on a prompt-response model</li>
  '
)

slide = Slide.create!
slide.parts.create!(
  part_type: 'headline',
  contents: 'RoR is full-stack<br />Use LLMs like a full-stack!'
)

slide = Slide.create!
slide.parts.create!(
  part_type: 'headline',
  contents: '<br />Voice Control<br /><br />'
)

slide = Slide.create!
slide.parts.create!(
  part_type: 'headline',
  contents: 'LLM-Driven<br />Voice Control<br /><br />'
)

slide = Slide.create!
slide.parts.create!(
  part_type: 'headline',
  contents: 'LLM-Driven<br />Voice Control<br />made fun<br />'
)

slide = Slide.create!
slide.parts.create!(
  part_type: 'partial_raw',
  contents: '/slides/seeds/meadow'
)

slide = Slide.create!(title: 'Voice Control - The Plan')
slide.parts.create!(
  part_type: 'partial',
  position: 1,
  contents: '/slides/seeds/voice_control_plan_1'
)

slide = Slide.create!(title: 'Record Audio')
slide.parts.create!(
  part_type: 'container',
  position: 1,
  contents: '<strong>JavaScript</strong> allows to interact with microphone.<br /><strong>MediaRecorder</strong> is available in a vast majority of browsers.'
)
slide.parts.create!(
  part_type: 'code/javascript',
  position: 2,
  contents: "const stream = await navigator.mediaDevices.getUserMedia({
  video: false, audio: true,
});

mediaRecorder = new MediaRecorder(stream, { mimeType: 'audio/webm' });
mediaRecorder.addEventListener('dataavailable', (event) => { sendAudio(event.data) });"
)
slide.parts.create!(
  part_type: 'one_line',
  position: 3,
  contents: "Start and stop the recording."
)
slide.parts.create!(
  part_type: 'code/javascript',
  position: 4,
  contents: "mediaRecorder.start();
// speak...
mediaRecorder.stop();"
)

slide = Slide.create!(title: 'Send Audio to a Server')
slide.parts.create!(
  part_type: 'code/javascript',
  position: 1,
  contents: '
sendAudio(audioBlob) {
  const formData = new FormData();
  formData.append("audio", audioBlob, "recording.webm");

  fetch("http://server.url/audios", {
    body: formData,
    method: "POST",
    headers: { "X-CSRF-Token": this.csrfToken }
  }).then(
    response => { if (!response.ok) { throw new Error(response.status); } }
  )
}
')
slide.parts.create!(
  part_type: 'container',
  position: 2,
  contents: 'Handle the end or recording in Javascript and send to Rails.'
)

slide = Slide.create!(title: 'Send Audio to a Server')
slide.parts.create!(
  part_type: 'code/javascript',
  position: 2,
  contents: '
sendAudio(audioBlob) {
  const formData = new FormData();
  formData.append("audio", audioBlob, "recording.webm");

  fetch("http://server.url/audios", {
    body: formData,
    method: "POST",
    headers: { "X-CSRF-Token": this.csrfToken }
  }).then(
    response => { if (!response.ok) { throw new Error(response.status); } }
  )
}
')
slide.parts.create!(
  part_type: 'code/ruby',
  position: 3,
  contents: '
class AudiosController < ApplicationController
  def create
    @audio = Audio.create!(file: params[:audio])

    # ...
  end
end
')

slide = Slide.create!(title: 'Voice Control - The Plan')
slide.parts.create!(
  part_type: 'partial',
  position: 1,
  contents: '/slides/seeds/voice_control_plan_2'
)

slide = Slide.create!(title: "Ruby OpenAI gem &nbsp;❤️❤️❤️")
slide.parts.create!(
  part_type: 'list',
  position: 1,
  contents: '
  <li>An easy way to connect to popular LLMs</li>
  <li>Get from https://github.com/alexrudall/ruby-openai</li>'
)
slide.parts.create!(
  part_type: 'code/ruby',
  position: 2,
  contents: '
require "openai"

OpenAIClient = OpenAI::Client.new(access_token: ACCESS_TOKEN)

OpenAIClient.chat
OpenAIClient.completions
OpenAIClient.embeddings
OpenAIClient.assistants
# ...
')

slide = Slide.create!(title: 'Convert Audio to Text')
slide.parts.create!(
  part_type: 'container',
  position: 1,
  contents: "Ask an LLM what's in the recording"
)
slide.parts.create!(
  part_type: 'code/ruby',
  position: 2,
  contents: '
class Audio < ApplicationRecord
  has_one_attached :file

  def transcribe
    return unless file.attachment.present?

    file.open do |file|
      response = OpenAIClient.audio.translate(
        parameters: {
          model: "whisper-1",
          file: file
        }
      )
      self.transcription = response["text"]
    end
  end
')

slide.parts.create!(
  part_type: 'one_line',
  position: 1,
  contents: 'The answer is a string like <strong>"Hey Gem, go to the right"</strong>'
)


slide = Slide.create!(title: 'Figure out what to do')
slide.parts.create!(
  part_type: 'container',
  position: 1,
  contents: '
  <div class="flex flex-col">
    <div class="w-full mb-6">
      <span class="font-bold">Prompt: </span><span class="font-mono text-3xl">"Hey Gem, go to the right"</span>
    </div>
    <div class="w-full flex justify-left gap-3">
      <div class="w-1/3 bg-slate-100 p-4">
        <span class="font-bold">
          Answer<br />
        </span>
        <span class="font-mono text-3xl">
          "It seems like you\'re trying to move something to the right. Could you please clarify what you\'re referring to, so I can help accordingly?"
        </span>
      </div>

      <div class="w-1/3">
      </div>

      <div class="w-1/3">
      </div>
    </div>
  </div>
')

slide = Slide.create!(title: 'Figure out what to do')
  slide.parts.create!(
    part_type: 'container',
    position: 1,
    contents: '
  <div class="flex flex-col">
    <div class="w-full mb-6">
      <span class="font-bold">Prompt: </span><span class="font-mono text-3xl">"Hey Gem, go to the right"</span>
    </div>
    <div class="w-full flex justify-left gap-3">
      <div class="w-1/3 bg-slate-100 p-4">
        <span class="font-bold">
          Answer<br />
        </span>
        <span class="font-mono text-3xl">
          "It seems like you\'re trying to move something to the right. Could you please clarify what you\'re referring to, so I can help accordingly?"
        </span>
      </div>

      <div class="w-1/3 bg-slate-200 p-4">
        <span class="font-bold">
          Tools<br />
        </span>
        <span class="font-mono text-3xl">
          <span class="font-bold">move_left</span><br />&nbsp;&nbsp;used to move left<br />
          <span class="font-bold">move_right</span><br />&nbsp;&nbsp;used to move right<br />
          <br />
        </span>
        <span class="font-bold">
          Answer<br />
        </span>
        <span class="font-mono text-3xl">
          "move_right"
        </span>
      </div>

      <div class="w-1/3">
      </div>
    </div>
  </div>
  ')

  slide = Slide.create!(title: 'Figure out what to do')
    slide.parts.create!(
      part_type: 'container',
      position: 1,
      contents: '
  <div class="flex flex-col">
    <div class="w-full mb-6">
      <span class="font-bold">Prompt: </span><span class="font-mono text-3xl">"Hey Gem, go to the right"</span>
    </div>
    <div class="w-full flex justify-left gap-3">
      <div class="w-1/3 bg-slate-100 p-4">
        <span class="font-bold">
          Answer<br />
        </span>
        <span class="font-mono text-3xl">
          "It seems like you\'re trying to move something to the right. Could you please clarify what you\'re referring to, so I can help accordingly?"
        </span>
      </div>

      <div class="w-1/3 bg-slate-200 p-4">
        <span class="font-bold">
          Tools<br />
        </span>
        <span class="font-mono text-3xl">
          <span class="font-bold">move_left</span><br />&nbsp;&nbsp;used to move left<br />
          <span class="font-bold">move_right</span><br />&nbsp;&nbsp;used to move right<br />
          <br />
        </span>
        <span class="font-bold">
          Answer<br />
        </span>
        <span class="font-mono text-3xl">
          "move_right"
        </span>
      </div>

      <div class="w-1/3 bg-slate-300 p-4">
        <span class="font-bold">
          Tools<br />
        </span>
        <span class="font-mono text-3xl">
          <span class="font-bold">move(x)</span><br />&nbsp;&nbsp;move to X location.<br />&nbsp;&nbsp;X is a number between<br />&nbsp;&nbsp;-3 and 3<br />
          <span class="font-bold">sing(lyrics)</span><br />&nbsp;&nbsp;sing the given lyrics<br />
          <br />
        </span>
        <span class="font-bold">
          Answer<br />
        </span>
        <span class="font-mono text-3xl">
          "move", { x: 3 }
        </span>
      </div>
    </div>
  </div>
    ')

slide = Slide.create!(title: 'Figure out what to do - with Ruby')
slide.parts.create!(
  part_type: 'code/ruby',
  position: 1,
  contents: '
OpenAIClient.chat(parameters: {
  model: "gpt-4o",
  messages: [ { "role": "user", "content": "Hey Gem, go to the right" } ],
  tools: [
    {
      type: "function",
      function: {
        name: "moveTo",
        description: "Move the dog called Gem to a given section of the screen",
        parameters: {
          type: :object,
          properties: {
            x: { type: :number, description: "The x-coordinate, ranging from -3 to 3" }
          }
        }
      },
    },
    { ... another function },
    { ... yet another function }
  ]
})')

slide = Slide.create!(title: 'Figure out what to do - with Ruby')
slide.parts.create!(
  part_type: 'code/ruby',
  position: 1,
  contents: '
OpenAIClient.chat(parameters: {
  model: "gpt-4o",
  messages: [ { "role": "user", "content": "Hey Gem, go to the right" } ],
  tools: [ ... ]
})')
slide.parts.create!(
  part_type: 'code/ruby',
  position: 3,
  contents: '
=> {
  "role" => "assistant",
  "tool_calls" => [
    {
      "id" => "call_9FKJepaHrCFqkUkRR1zZVESj",
      "type" => "function",
      "function" => {
        "name" => "moveTo",
        "arguments" => "{\"x\":3}"
      }
    }
  ],
  "content" => nil, "refusal" => nil
}'
)

slide = Slide.create!(title: 'Figure out what to do - with Ruby')
slide.parts.create!(
  part_type: 'code/ruby',
  position: 2,
  contents: '
class Audio < ApplicationRecord
  has_one_attached :file

  def transcribe
    # ...
    self.transcription = response["text"]
  end

  def process
    response = OpenAIClient.chat(
      parameters: {
        model: "gpt-4o",
        messages: [ { "role": "user", "content": transcription } ],
        tools: [ ... ]
      }
    )
    # ...

    self.command = parse_command_name(response) # => "moveTo"
    self.command_params = parse_command_params(response) # => { x: 3 }
  end
')

slide = Slide.create!(title: 'Voice Control - The Plan')
slide.parts.create!(
  part_type: 'partial',
  position: 1,
  contents: '/slides/seeds/voice_control_plan_3'
)

slide = Slide.create!(title: 'Broadcast')
  slide.parts.create!(
    part_type: 'code/ruby',
    position: 2,
    contents: '
  class Audio < ApplicationRecord
    has_one_attached :file

    def transcribe
      # ...
      self.transcription = response["text"]
    end

    def process
      # ...
      self.command = parse_command_name(response)
      self.command_params = parse_command_params(response)
    end

    def broadcast
      Turbo::StreamsChannel.broadcast_append_to(
        "audios",
        target: "audios", partial: "audios/audio", locals: { audio: self }
      )
    end
')

slide = Slide.create!(title: 'Broadcast')
slide.parts.create!(
  part_type: 'partial_raw',
  position: 1,
  contents: '/slides/seeds/broadcast_1'
)

slide = Slide.create!(title: 'Broadcast')
slide.parts.create!(
  part_type: 'partial_raw',
  position: 1,
  contents: '/slides/seeds/broadcast_2'
)

slide = Slide.create!(title: 'Call JavaScript after Broadcast')
slide.parts.create!(
  part_type: 'partial_raw',
  position: 1,
  contents: '/slides/seeds/broadcast_3'
)

slide = Slide.create!(title: 'Voice Control - We did it!')
slide.parts.create!(
  part_type: 'partial',
  position: 1,
  contents: '/slides/seeds/voice_control_plan_4'
)

slide = Slide.create!(title: 'Make the web more available')
slide.parts.create!(
  part_type: 'partial',
  position: 1,
  contents: '/slides/seeds/small_font'
)

slide = Slide.create!(title: 'Make the web more available')
slide.parts.create!(
  part_type: 'partial',
  position: 1,
  contents: '/slides/seeds/dark_mode'
)

slide = Slide.create!
slide.parts.create!(
  part_type: 'partial_raw',
  position: 1,
  contents: '/slides/seeds/notebook_filters'
)
