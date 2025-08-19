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
end
