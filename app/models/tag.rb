class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :questions, through: :taggings, source: :taggable, source_type: "Question"

  validates :slug, uniqueness: true, presence: true

  before_save :sanitize_slug, if: :slug_will_change!

  def to_label
    slug
  end

  private

  def sanitize_slug
    self.slug = slug.parameterize
  end
end
