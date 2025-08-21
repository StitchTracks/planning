class Section < ApplicationRecord
  belongs_to :chapter
  has_many :chunks, dependent: :destroy
  has_many :pok_items, dependent: :nullify
  has_many :subject_items, dependent: :nullify
  default_scope { order(index: :asc) }

  def full_name
    "#{self.chapter.track.name} | #{self.chapter.name} | #{self.name}"
  end

  def pok_count
    PokItem.where(section: self).count
  end

  def self.reorderSectionsFor(chapter)
      sections = Section.where(chapter: chapter).order(index: :asc)
      ix = 1
      sections.each do |section|
        if section.index != 0
          section.update(index: ix)
          ix += 1
        end
      end
  end

  def changeIndex(adjust)
    chapter_sections = Section.where(chapter: self.chapter)
    new_index = self.index + adjust
    swap_section = chapter_sections.where(index: new_index)
    if swap_section
      swap_section.update(index: self.index)
    end
    self.update(index: new_index)
    Section.reorderSectionsFor(self.chapter)
  end
end
