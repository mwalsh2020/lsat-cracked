class QuizSession < ApplicationRecord
  belongs_to :user
  belongs_to :section

  has_many :quiz_questions
  has_many :questions, through: :quiz_questions

  accepts_nested_attributes_for :quiz_questions

  validates :questions, presence: true

  scope :complete, -> { where(complete: true) }
  scope :pending, -> { where.not(complete: true) }
end
