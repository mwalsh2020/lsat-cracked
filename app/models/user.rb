class User < ApplicationRecord
  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :validatable

  has_many :quizzes, dependent: :destroy
  has_many :quiz_questions, through: :quizzes
  has_many :answers, through: :quiz_questions

  scope :admin, -> { where(admin: true) }

  def last_quiz_for(section)
    quizzes.order(created_at: :desc).find_by(user: self, quizable: section)
  end

  def name
    email
  end

  def guest?
    false
  end
end
