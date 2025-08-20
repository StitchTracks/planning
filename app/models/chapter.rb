class Chapter < ApplicationRecord
  belongs_to :track
  has_many :sections, dependent: :destroy
  default_scope { order(index: :asc) }

  def full_name
    "#{self.track.name} | #{self.name}"
  end

  def pok_count
    pok_count = 0
    self.sections.each do |section|
      pok_count += section.pok_count
    end
    pok_count
  end

  def self.reorderChaptersFor(track)
      chapters = Chapter.where(track: track).order(index: :asc)
      ix = 1
      chapters.each do |chapter|
        if chapter.index != 0
          chapter.update(index: ix)
          ix += 1
        end
      end
  end

  def changeIndex(adjust)
    track_chapters = Chapter.where(track: self.track)
    new_index = self.index + adjust
    swap_chapter = track_chapters.where(index: new_index)
    if swap_chapter
      swap_chapter.update(index: self.index)
    end
    self.update(index: new_index)
    Chapter.reorderChaptersFor(self.track)
  end
end
