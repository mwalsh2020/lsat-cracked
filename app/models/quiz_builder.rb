class QuizBuilder
  attr_accessor :user, :section

  def build
    user.pending_quiz(section) || new_quiz
  end

  private

  def new_quiz
    Quiz.new(user: user, section: section)
  end
end
