class User::CourseStatus::SectionStatus
  attr_reader :section, :user
  delegate :title, :position, to: :section

  def initialize(params)
    @section = params[:section]
    @completed = params[:completed]
    @user = params[:user]
  end

  def completed?
    @completed
  end

  def recent_quiz
    user.last_quiz_for(section)
  end

  def quiz_score
    # FIXME: correct_answers probably is a quiz relation
    correct_answers.size.fdiv(recent_quiz.questions.size)
  end

  # FIXME: probably is a quiz relation
  def correct_answers
    recent_quiz.answers.correct
  end

  def position
    section.position
  end

  include Comparable
  def <=>(other)
    position <=> other.position
  end
end
