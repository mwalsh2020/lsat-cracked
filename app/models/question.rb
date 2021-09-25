class Question < ApplicationRecord
  has_rich_text :prompt
  has_rich_text :explanation

  has_many :answers, dependent: :destroy
  has_many :quiz_questions, dependent: :destroy
  accepts_nested_attributes_for :answers, reject_if: :all_blank,
                                          allow_destroy: true

  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :quizable_questions, dependent: :destroy

  has_many :sections, through: :quizable_questions, source: :quizable,
                      source_type: "Section"
  has_many :articles, through: :quizable_questions, source: :quizable,
                      source_type: "Article"

  scope :where_quizable, ->(quizable) {
                           joins(:quizable_questions).where(quizable_questions: { quizable: quizable })
                         }
  scope :with_questions_and_answers, -> {
                                       includes(:rich_text_prompt, :taggings, :tags, answers: [:rich_text_content])
                                     }

  def premium?
    tags.any?(&:premium?)
  end

  def tag_slugs=(slugs)
    self.tags = slugs.map do |slug|
      Tag.find_or_create_by!(slug: slug)
    end
  end
end
