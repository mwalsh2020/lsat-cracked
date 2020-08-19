class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  has_many :quizzes, dependent: :destroy

  def pending_quiz(section)
    quizzes.pending.find_by(user: self, section: section)
  end

  def answered_quiz?(section)
    quizzes.complete.exists?(user: self, section: section)
  end
end
