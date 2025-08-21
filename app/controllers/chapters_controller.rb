class ChaptersController < ApplicationController
  before_action :set_chapter, only: [ :show, :destroy, :update, :preview, :move_section ]

  def create
    @chapter = Chapter.new(chapter_params)
    @chapter.save
    Section.create(index: 0, name: "---", chapter: @chapter)
    redirect_to track_path(@chapter.track)
  end

  def show
    @section = Section.new
  end

  def destroy
    track = @chapter.track
    @chapter.destroy
    redirect_to track_path(track)
  end

  def edit
    @chapter = Chapter.find(params.require(:id))
  end

  def update
    @chapter.update(chapter_params)
    redirect_to @chapter.track, notice: "Chapter was successfully updated."
  end

  def move_section
    direction = params[:direction]
    section = Section.find(params[:section_id])
    adjust = direction == "down" ? -1 : 1
    section.changeIndex(adjust)
    redirect_to chapter_path(@chapter)
  end

  def preview
  end

  private
      def set_chapter
          @chapter = Chapter.find(params.expect(:id))
      end

      def chapter_params
          params.expect(chapter: [ :index, :name, :track_id ])
      end
end
