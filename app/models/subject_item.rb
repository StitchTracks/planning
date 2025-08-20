class SubjectItem < ApplicationRecord
  belongs_to :section, optional: true
  belongs_to :parent_item, class_name: "SubjectItem", optional: true
  has_many :child_items, class_name: "SubjectItem", foreign_key: "parent_item"
  default_scope { order(sequence: :asc) }

  def children
    SubjectItem.where(parent_item: self)
  end
end
