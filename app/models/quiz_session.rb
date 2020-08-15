class QuizSession < ApplicationRecord
  belongs_to :user
  belongs_to :section

  has_many :quiz_questions
  has_many :questions, through: :quiz_questions

  accepts_nested_attributes_for :quiz_questions

  validates :questions, presence: true

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
end
