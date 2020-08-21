# Decorator for building quiz sessions
class Quiz::Session
  include ActiveModel::Model

  attr_reader :quiz
  delegate :quiz_questions, :user, to: :quiz

  def initialize(quiz)
    @quiz = quiz
    model_name.instance_eval { @route_key = "sessions" }
  end

  def quiz_questions_attributes=(values)
    
  end

  def valid?
    quiz_questions.all?(&:answered?)
  end

  def correct_answers_ratio
    correct_answers_count.fdiv(quiz_questions.count)
  end

  def correct_answers_count
    quiz_questions.correctly_answered.count
  end

  def good_correct_ratio?
    correct_answers_ratio > 0.8
  end

  def save
    return false unless valid?

    binding.pry
  end
end
