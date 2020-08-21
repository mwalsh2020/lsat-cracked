class QuizQuestion < ApplicationRecord
  belongs_to :quiz
  belongs_to :question
  belongs_to :answer, optional: true

  has_many :possible_answers, through: :question, source: :answers

  scope :correctly_answered, -> { joins(:answer).where(answers: { correct: true }) }

  def correct?
    answered? && correct?
  end

  def answered?
    answer.present?
  end
end
