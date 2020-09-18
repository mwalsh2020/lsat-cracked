class Question < ApplicationRecord
  has_rich_text :prompt
  has_rich_text :explanation

  has_many :answers, dependent: :destroy
  has_many :quiz_questions, dependent: :destroy

  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :quiz_template_questions
  has_many :quiz_templates, through: :quiz_template_questions

  def premium?
    tags.any?(&:premium?)
  end

  def tag_slugs=(slugs)
    self.tags = slugs.map do |slug|
      Tag.find_or_create_by!(slug: slug)
    end
  end

  def quizables
    Section.where(quiz_template: quiz_templates) + Article.where(quiz_template: quiz_templates)
  end

  def quizable_params
    quizables.map { |quizable| { quizable_id: quizable.id, quizable_type: quizable.class.name } }
  end

  def quizable_attributes=(params = {})
  end
end
