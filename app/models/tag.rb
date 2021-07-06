class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :questions, through: :taggings, source: :taggable, source_type: "Question"
  has_many :quiz_questions, through: :questions

  belongs_to :user
  belongs_to :question

  validates :slug, uniqueness: true, presence: true

  before_save :sanitize_slug, if: :slug_will_change!

  delegate :count, to: :questions, prefix: :questions

  def to_label
    slug
  end

  private

  def sanitize_slug
    self.slug = slug.parameterize
  end
end
