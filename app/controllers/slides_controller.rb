class SlidesController < ApplicationController
  def index
    redirect_to Slide.first
  end

  def show
    @slide = Slide.find(params[:id])

    @slide_next = Slide.where("id > ?", @slide.id).order(id: :asc).first
    @slide_prev = Slide.where("id < ?", @slide.id).order(id: :desc).first
  end
end
