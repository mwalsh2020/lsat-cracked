class User < ApplicationRecord
  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :validatable

  has_many :quizzes, dependent: :destroy

  scope :admin, -> { where(admin: true) }

  def last_quiz_for(section)
    quizzes.order(created_at: :desc).find_by(user: self, section: section)
  end

  def name
    email
  end

  def guest?
    false
  end
end
