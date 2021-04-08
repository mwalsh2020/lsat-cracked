# Decorator for building quiz sessions
class Quiz::Session
  include ActiveModel::Model

  attr_writer :quiz
  attr_reader :quiz_questions

  delegate :user, :complete?, to: :quiz

  def initialize(params)
    @quiz_questions = params[:quiz].quiz_questions
    @quiz = params[:quiz]
    super(params)
    model_name.instance_eval { @route_key = "sessions" }
  end

  def quiz
    @quiz ||= Quiz.new
  end

  def quiz_questions_attributes=(values)
    quiz_questions_proxy = values.map do |_key, quiz_question_params|
      quiz_question = QuizQuestion.find_by(id: quiz_question_params[:id]) ||
                      QuizQuestion.new(quiz_question_params)
      quiz_question.assign_attributes(quiz_question_params)
      quiz_question.question ||= quiz_question.answer.question
      quiz_question.quiz ||= quiz
      quiz_question
    end
    quiz.quiz_questions = quiz_questions_proxy
    @quiz_questions = quiz.quiz_questions
  end

  def reportable?
    complete? && !ignored?
  end

  def valid?
    @quiz_questions.map(&:answered?).all?
  end

  def ignored?
    @quiz_questions.empty?
  end

  def correct_answers_ratio
    quiz_size = @quiz_questions.size
    rational_params = quiz_size.zero? ? [1, 1] : [correct_answers_count, quiz_size]
    Rational(*rational_params).to_f
  end

  def correct_answers_count
    @quiz_questions.count(&:correct?)
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
    quiz.update(complete: true, ignored: ignored?)
    true
  end
end
