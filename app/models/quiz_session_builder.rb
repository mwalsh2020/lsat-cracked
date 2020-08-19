class QuizSessionBuilder
  attr_accessor :user, :section

  def build
    user.pending_quiz(section)
  end
end
