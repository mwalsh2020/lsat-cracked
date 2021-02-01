class QuizBuilder
  attr_accessor :user, :section, :quizable

  def initialize(params = {})
    @user     = params[:user]
    @section  = params[:section]
    @quizable = params[:quizable]
  end

  def quiz
    @quiz ||= Quiz.new(quizable: section, questions: section.questions)
  end

  def new_quiz
    quiz.user = user.persisted? ? user : User.new
    quiz
  end

  def build
    user.last_quiz_for(section) || new_quiz
  end

  def build_and_save
    quiz = build
    quiz.save
    quiz
  end
end
