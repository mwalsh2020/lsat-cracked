# Decorator for building quiz sessions
class Quiz::Session
  include ActiveModel::Model

  attr_accessor :quiz
  attr_reader :quiz_questions

  delegate :user, :complete?, to: :quiz

  def initialize(params)
    @quiz_questions = params[:quiz].quiz_questions
    super(params)
    model_name.instance_eval { @route_key = "sessions" }
  end

  def quiz_questions_attributes=(values)
    @quiz_questions = values.map do |_key, quiz_question_params|
      quiz_question = QuizQuestion.find(quiz_question_params[:id])
      quiz_question.assign_attributes(quiz_question_params)
      quiz_question
    end
  end

  def valid?
    @quiz_questions.map(&:answered?).all?
  end

  def present?
    @quiz_questions.any?
  end

  def correct_answers_ratio
    correct_answers_count.fdiv(@quiz_questions.count)
  end

  def correct_answers_count
    @quiz_questions.correctly_answered.count
  end

  def good_correct_ratio?
    correct_answers_ratio > 0.8
  end

  def premium?
    @quiz_questions.any?(&:premium?)
  end

  def save
    return false unless valid?

    @quiz_questions.all?(&:save!)
    quiz.update(complete: true)
    true
  end
end
