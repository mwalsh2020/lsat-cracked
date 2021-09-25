class QuizQuestion < ApplicationRecord
  belongs_to :quiz
  belongs_to :question
  belongs_to :answer, optional: true

  has_many :possible_answers, through: :question, source: :answers
  has_many :tags, through: :question
  accepts_nested_attributes_for :tags, reject_if: :all_blank,
                                       allow_destroy: true

  scope :correctly_answered, -> {
                               joins(:answer).where(answers: { correct: true })
                             }

  def correct?
    answer&.correct?
  end

  def premium?
    question.premium?
  end

  def answered?
    if answer.present?
      true
    else
      errors.add(:answer, "to proceed")
      false
    end
  end
end
