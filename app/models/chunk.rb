class Chunk < ApplicationRecord
  belongs_to :section
  default_scope { order(index: :asc) }

  def self.reorderChunksFor(section)
      chunks = Chunk.where(section: section).order(index: :asc)
      ix = 1
      chunks.each do |chunk|
        chunk.update(index: ix)
        ix += 1
      end
  end

  def changeIndex(adjust)
    section_chunks = Chunk.where(section: self.section)
    new_index = self.index + adjust
    swap_chunk = section_chunks.where(index: new_index)
    if swap_chunk
      swap_chunk.update(index: self.index)
    end
    self.update(index: new_index)
    Chunk.reorderChunksFor(self.section)
  end
end
