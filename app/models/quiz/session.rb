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
end
