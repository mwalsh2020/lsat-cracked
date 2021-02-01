class QuizBuilder
  attr_accessor :user, :section, :quizable

  def initialize(params = {})
    @user     = params[:user]
    @section  = params[:section]
    @quizable = params[:quizable]
  end

  def new_quiz
    Quiz.new(user: user, quizable: section, questions: @section.questions)
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
