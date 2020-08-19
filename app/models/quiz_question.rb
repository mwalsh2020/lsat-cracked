class QuizQuestion < ApplicationRecord
  belongs_to :quiz_session
  belongs_to :question
  belongs_to :answer, optional: true

  has_many :possible_answers, through: :question, source: :answers

  scope :correctly_answered, -> { joins(:answer).where(answers: { correct: true }) }

  validate :answered, if: :quiz_session_complete?

  def correct?
    answer&.correct?
  end

  def answered
    errors.add(:answer, "is needed in order to proceeed") if answer.blank?
  end

  private

  def quiz_session_complete?
    quiz_session.complete?
  end
end
