class QuizSession < ApplicationRecord
  belongs_to :user
  belongs_to :section

  has_many :quiz_questions, dependent: :destroy
  has_many :questions, through: :quiz_questions

  accepts_nested_attributes_for :quiz_questions

  validates :questions, presence: true
  validate :fully_answered, if: :complete?

  scope :complete, -> { where(complete: true) }
  scope :pending, -> { where.not(complete: true) }

  def correct_answers_ratio
    correct_answers_count.fdiv(quiz_questions.count)
  end

  def correct_answers_count
    quiz_questions.correctly_answered.count
  end

  def good_correct_ratio?
    correct_answers_ratio > 0.8
  end

  private

  def fully_answered
    errors.add(:quiz_questions, "must be fully answered to proceed") unless questions_answered?
  end

  def questions_answered?
    quiz_questions.each(&:valid?)
    quiz_questions.all?(&:valid?)
  end
end
