class Section < ApplicationRecord
  has_rich_text :content

  belongs_to :chapter

  has_one :quiz_template, as: :quizable, dependent: :destroy
  has_many :questions, through: :quiz_template

  has_many :quizzes, as: :quizable, dependent: :destroy

  acts_as_list scope: :chapter

  def add_question(question)
    find_or_create_quiz_template
      .quiz_template_questions
      .create(question: question)
      .persisted?
  end

  private

  def find_or_create_quiz_template
    quiz_template || create_quiz_template
  end
end
