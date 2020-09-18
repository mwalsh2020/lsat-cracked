class Question < ApplicationRecord
  has_rich_text :prompt
  has_rich_text :explanation

  has_many :answers, dependent: :destroy
  has_many :quiz_questions, dependent: :destroy

  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :quizable_questions
  has_many :sections, source: :quizable, source_type: "Section", through: :quizable_questions
  has_many :articles, source: :quizable, source_type: "Article", through: :quizable_questions

  def premium?
    tags.any?(&:premium?)
  end

  def tag_slugs=(slugs)
    self.tags = slugs.map do |slug|
      Tag.find_or_create_by!(slug: slug)
    end
  end
end
