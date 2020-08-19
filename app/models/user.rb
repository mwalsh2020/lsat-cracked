class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  has_many :quiz_sessions, dependent: :destroy

  def pending_quiz(section)
    quiz_sessions.pending.find_by(user: self, section: section)
  end

  def answered_quiz?(section)
    quiz_sessions.complete.exists?(user: self, section: section)
  end
end
