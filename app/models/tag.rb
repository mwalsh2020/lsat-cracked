class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :questions, through: :taggings, source: :taggable, source_type: "Question"

  validates :slug, uniqueness: true, presence: true

  def to_label
    slug
  end
end
