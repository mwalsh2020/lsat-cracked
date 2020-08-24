class QuizBuilder
  attr_accessor :user, :section

  def initialize(params = {})
    @user    = params[:user]
    @section = params[:section]
  end

  def build
    user.last_quiz_for(section) || new_quiz
  end

  def build_and_save
    quiz = build
    quiz.save
    quiz
  end

  private

  def new_quiz
    Quiz.new(user: user, section: section, questions: @section.questions)
  end
end
