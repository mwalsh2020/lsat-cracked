class User < ApplicationRecord
  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :validatable, :trackable

  has_many :quizzes, dependent: :destroy
  has_many :completed_quizzes, -> { where(complete: true) }, class_name: "Quiz"
  has_many :completed_sections, -> { distinct }, through: :completed_quizzes, source: :quizable, source_type: "Section"
  has_many :quiz_questions, through: :quizzes
  has_many :answers, through: :quiz_questions
  has_many :tags, ->{distinct}, through: :quiz_questions
  has_many :orders, dependent: :destroy
  
  after_save :enqueue_ping_lsac if :prep_plus_changed?

  scope :admin, -> { where(admin: true) }

  def last_quiz_for(quizable)
    quizzes.order(created_at: :desc).find_by(user: self, quizable: quizable)
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

  def enqueue_ping_lsac
    PingLsacJob.perform_later(self.id)
  end
end
