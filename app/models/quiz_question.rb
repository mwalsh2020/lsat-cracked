class QuizQuestion < ApplicationRecord
  belongs_to :quiz_session
  belongs_to :question
  belongs_to :answer, optional: true

  has_many :possible_answers, through: :question, source: :answers
end
