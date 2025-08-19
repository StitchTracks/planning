class Track < ApplicationRecord
  has_many :chapters, dependent: :destroy
  default_scope { order(index: :asc) }

  def pok_count
    pok_count = 0
    self.chapters.each do |chapter|
      pok_count += chapter.pok_count
    end
    pok_count
  end
end
