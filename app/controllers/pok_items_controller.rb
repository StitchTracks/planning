class PokItemsController < ApplicationController
  def orphans
    @pok_items = PokItem.all
  end

  def chapters
    @chapters = PokItem.where(level: 1)
  end

  def show
    @pok_item = PokItem.find(params.expect(:id))
    if @pok_item.level == 1
      redirect_to chapter_pok_item_path(@pok_item)
    end
    if @pok_item.level == 2
      redirect_to section_pok_item_path(@pok_item)
    end
    if @pok_item.level == 3
      redirect_to subsection_pok_item_path(@pok_item)
    end
  end

  def chapter
    @pok_chapter = PokItem.find(params.expect(:id))
    @pok_items = @pok_chapter.children

    @pok_chapter.children.each do |section|
      @pok_items = @pok_items.or(section.children)
      section.children.each do |subsection|
        @pok_items = @pok_items.or(subsection.children)
        subsection.children.each do |detail|
          @pok_items = @pok_items.or(detail.children)
          detail.children.each do |subdetail|
            @pok_items = @pok_items.or(subdetail.children)
          end
        end
      end
    end
  end

  def section
    @pok_section = PokItem.find(params.expect(:id))
    @pok_items = @pok_section.children

    @pok_section.children.each do |subsection|
      @pok_items = @pok_items.or(subsection.children)
      subsection.children.each do |detail|
        @pok_items = @pok_items.or(detail.children)
        detail.children.each do |subdetail|
          @pok_items = @pok_items.or(subdetail.children)
        end
      end
    end
  end

  def subsection
    @pok_subsection = PokItem.find(params.expect(:id))
    @pok_items = @pok_subsection.children

    @pok_subsection.children.each do |detail|
      @pok_items = @pok_items.or(detail.children)
      detail.children.each do |subdetail|
        @pok_items = @pok_items.or(subdetail.children)
      end
    end
  end

  def assign_to_chapter
    pok_item = PokItem.find(params[:pok_item_id])
    st_chapter = Chapter.find(params[:st_chapter_id])
    st_section = st_chapter.sections.order(index: :asc).first
    pok_item.update(section: st_section)
    if pok_item.level == 1
      redirect_to chapters_pok_items_path
    else
      redirect_to pok_item_path(params.expect(:id))
    end
  end

  def unassign
    pok_item = PokItem.find(params[:pok_item_id])
    pok_item.update(section: nil)
    redirect_to pok_item_path(params.expect(:id))
  end
end
