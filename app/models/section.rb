class Section < ApplicationRecord
  belongs_to :chapter
  has_many :chunks, dependent: :destroy
  has_many :pok_items, dependent: :nullify
  default_scope { order(index: :asc) }

  def full_name
    "#{self.chapter.track.name} | #{self.chapter.name} | #{self.name}"
  end

  def pok_count
    PokItem.where(section: self).count
  end
end
