class TracksController < ApplicationController
  before_action :set_track, only: [ :show, :destroy, :edit, :update, :preview, :preview_unformatted, :pok_items, :assign_to_chapter, :move_chapter, :move_to ]

  def index
    @tracks = Track.all
  end

  def new
    @track = Track.new
  end

  def create
    @track = Track.new(track_params)
    @track.save
    redirect_to tracks_path
  end

  def show
    @chapter = Chapter.new
  end

  def destroy
    @track.destroy
    redirect_to tracks_path
  end

  def edit
    @track = Track.find(params.require(:id))
  end

  def update
    @track.update(track_params)
    redirect_to @track, notice: "Track was successfully updated."
  end

  def preview
  end

  def preview_unformatted
  end

  def pok_items
    @pok_items = PokItem.none
    @track.chapters.each do |chapter|
      chapter.sections.each do |section|
        @pok_items = @pok_items.or(PokItem.where(section: section))
      end
    end
  end

  def assign_to_chapter
    pok_item = PokItem.find(params[:pok_item_id])
    st_chapter = Chapter.find(params[:st_chapter_id])
    st_section = st_chapter.sections.order(index: :asc).first
    pok_item.update(section: st_section)
    redirect_to track_path(params.expect(:id))
  end

  def section_absorb_orphan_PoKs
    section = Section.find(params[:section_id])
    PokItem.where(section: nil).each do |pi|
      pi.update(section: section)
    end
    redirect_to track_path(params.expect(:id))
  end

  def move_to
    chapter = Chapter.find(params[:chapter_id])
    track = Track.find(params[:new_track_id])
    chapter.update(track: track)
    redirect_to track_path(@track)
  end

  def move_chapter
    direction = params[:direction]
    chapter = Chapter.find(params[:chapter_id])
    adjust = direction == "down" ? -1 : 1
    chapter.changeIndex(adjust)
    redirect_to track_path(@track)
  end

  private
    def set_track
      @track = Track.find(params.expect(:id))
    end

    def track_params
      params.expect(track: [ :index, :name ])
    end
end
