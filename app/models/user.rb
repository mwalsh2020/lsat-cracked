class User < ApplicationRecord
  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :validatable

  has_many :quizzes, dependent: :destroy
  has_many :completed_quizzes, -> { where(complete: true) }, class_name: "Quiz"
  has_many :completed_sections, through: :completed_quizzes, source: :quizable, source_type: "Section"

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

  def course_status
    @course_status ||= User::CourseStatus.new(self)
  end
end
