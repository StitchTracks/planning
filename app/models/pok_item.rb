class PokItem < ApplicationRecord
  belongs_to :section, optional: true
  belongs_to :parent_item, class_name: "PokItem", optional: true
  has_many :child_items, class_name: "PokItem", foreign_key: "parent_item"
  default_scope { order(sequence: :asc) }

  def children
    PokItem.where(parent_item: self)
  end
end
