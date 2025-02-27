class AudiosController < ApplicationController
  def create
    @audio = Audio.new(file: params[:audio])
    @audio.save!

    redirect_to :audios, notice: "Audio was successfully created."
  end

  def index
  end

  def audio_params
    params.expect(audio: [ :file ])
  end
end
