class QuizSessionBuilder
  attr_accessor :user, :section

  def build
    user.pending_quiz(section) || new_quiz_session
  end

  private

  def new_quiz_session
    QuizSession.new(user: user, section: section)
  end
end
