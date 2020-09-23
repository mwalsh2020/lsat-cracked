class Question < ApplicationRecord
  has_rich_text :prompt
  has_rich_text :explanation

  has_many :answers, dependent: :destroy
  has_many :quiz_questions, dependent: :destroy

  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  scope :with_questions_and_answers, -> { includes(:rich_text_prompt, :taggings, :tags, answers: [:rich_text_content ]) }

  def premium?
    tags.any?(&:premium?)
  end

  def tag_slugs=(slugs)
    self.tags = slugs.map do |slug|
      Tag.find_or_create_by!(slug: slug)
    end
  end
end
