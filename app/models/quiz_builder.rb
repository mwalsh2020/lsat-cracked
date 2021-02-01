class QuizBuilder
  attr_accessor :user, :quizable

  def initialize(params = {})
    if params[:section]
      # TODO: Add an Outdated interface used warning
    end

    @user     = params[:user]
    @quizable = params[:quizable] || params[:section]
  end

  def section
    # TODO: Add an Outdated interface used warning
    @quizable
  end

  def section=(quizable)
    # TODO: Add an Outdated interface used warning
    @quizable = quizable
  end

  def quiz
    @quiz ||= Quiz.new(quizable: quizable, questions: quizable.questions)
  end

  def new_quiz
    quiz.user = user.persisted? ? user : User.new
    quiz
  end

  def build
    user.last_quiz_for(quizable) || new_quiz
  end

  def build_and_save
    quiz = build
    quiz.save!
    quiz
  end
end
