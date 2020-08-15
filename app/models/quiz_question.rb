class QuizQuestion < ApplicationRecord
  belongs_to :quiz_session
  belongs_to :question
  belongs_to :answer, optional: true

  has_many :possible_answers, through: :question, source: :answers

  scope :correctly_answered, -> { joins(:answer).where(answers: { correct: true }) }

  def correct?
    answer&.correct?
  end
end
