class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  def answered_quiz?(section)
    QuizSession.complete.exists?(user: self, section: section)
  end
end
