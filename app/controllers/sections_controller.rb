class SectionsController < ApplicationController
  before_action :set_section, only: [ :show, :destroy, :update, :associate_pok_item, :unassociate_pok_item, :move_pok_item_to, :add_subtitle_chunk, :add_copy_chunk, :add_figure_chunk, :add_video_chunk, :add_pattern_chunk, :move_chunk, :remove_chunk, :absorb_orphan_PoKs ]

  def create
    @section = Section.new(section_params)
    @section.save
    redirect_to chapter_path(@section.chapter)
  end

  def show
  end

  def destroy
    chapter = @section.chapter
    @section.destroy
    redirect_to chapter_path(chapter)
  end

  def edit
    @section = Section.find(params.require(:id))
  end

  def update
    @section.update(section_params)
    redirect_to @section.chapter, notice: "Section was successfully updated."
  end

  def turbo_pok_items
    @pok_items = Hash.new
    PokItem.where(page: params[:page]).where(section: nil).each do |item|
      @pok_items[item.description] = item.id
    end
    respond_to do |format|
      format.turbo_stream
    end
  end

  def add_subtitle_chunk
    Subtitle.create(
      section: @section,
      index: getNextIndex(@section),
      content: params[:subtitle]
    )
    redirect_to section_path(@section)
  end

  def add_copy_chunk
    Copy.create(
      section: @section,
      index: getNextIndex(@section),
      content: params[:copy]
    )
    redirect_to section_path(@section)
  end

  def add_figure_chunk
    Figure.create(
      section: @section,
      index: getNextIndex(@section),
      content: "#{params[:fig_num]}|#{params[:fig_desc]}"
    )
    redirect_to section_path(@section)
  end

  def add_video_chunk
    Video.create(
      section: @section,
      index: getNextIndex(@section),
      content: params[:video_desc]
    )
    redirect_to section_path(@section)
  end

  def add_pattern_chunk
    Pattern.create(
      section: @section,
      index: getNextIndex(@section),
      content: params[:pattern]
    )
    redirect_to section_path(@section)
  end

  def move_chunk
    direction = params[:direction]
    chunk = Chunk.find(params[:chunk_id])
    adjust = direction == "down" ? -1 : 1
    chunk.changeIndex(adjust)
    redirect_to section_path(@section)
  end

  def remove_chunk
    chunk = Chunk.find(params[:chunk_id])
    chunk.destroy
    Chunk.reorderChunksFor(@section)
    redirect_to section_path(@section)
  end

  def associate_pok_item
    pok_item = PokItem.find(params[:pok_item])
    pok_item.section = @section
    pok_item.save
    redirect_to section_path(@section)
  end

  def unassociate_pok_item
    pok_item = PokItem.find(params[:pok_item_id])
    pok_item.update(section: nil)
    redirect_to section_path(@section)
  end

  def move_pok_item_to
    prms = params.expect(pok_item: [ :pok_item_id, :section_id ])
    pok_item = PokItem.find(prms[:pok_item_id])
    pok_item.update(section_id: prms[:section_id])
    redirect_to section_path(@section)
  end

  def absorb_orphan_PoKs
    pok_orphans = PokItem.where(section: nil)
    pok_orphans.each do |orphan|
      orphan.update(section: @section)
    end
    redirect_to section_path(@section)
  end

  private
      def set_section
          @section = Section.find(params.expect(:id))
      end

      def section_params
          params.expect(section: [ :index, :name, :chapter_id ])
      end

      def getNextIndex(section)
        chunks = section.chunks.order(index: :asc)
        max = 0
        if chunks.count > 0
          max = chunks.last.index
        end
        max + 1
      end
end
