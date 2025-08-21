class ChunksController < ApplicationController
  def edit
    @chunk = Chunk.find(params.expect(:id))
    if @chunk.type == "Figure"
      a = @chunk.content.split("|")
      @fig_num = a[0]
      @fig_desc = a[1]
    end
  end

  def update
    @chunk = Chunk.find(params.expect(:id))
    @chunk.update(chunk_params(@chunk.type))
    redirect_to section_path(@chunk.section)
  end

  def chunk_params(type)
    if type == "Subtitle"
      params.expect(subtitle: [ :index, :content ])
    elsif type == "Copy"
      params.expect(copy: [ :index, :content ])
    elsif type == "Figure"
      params.expect(figure: [ :index, :content ])
    elsif type == "Video"
      params.expect(video: [ :index, :content ])
    elsif type == "Pattern"
      params.expect(pattern: [ :index, :content ])
    elsif type == "Aside"
      params.expect(aside: [ :index, :content ])
    else
      params.expect(chunk: [ :index, :content ])
    end
  end
end
