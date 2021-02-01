module Quizable
  extend ActiveSupport::Concern

  included do
    has_many :quizzes, as: :quizable, dependent: :destroy
    has_many :quizable_questions, as: :quizable, dependent: :destroy
    has_many :questions, through: :quizable_questions
  end
end
