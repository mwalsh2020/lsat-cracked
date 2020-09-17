class QuizTemplate < ApplicationRecord
  belongs_to :quizable, polymorphic: true

  has_many :quiz_template_questions, dependent: :destroy
  has_many :questions, through: :quiz_template_questions
end
