require_relative "course_status"

class User::SectionStatus < User::CourseStatus
  attr_reader :section
  delegate :title, :position, :quiz_score, to: :section

  def initialize(params)
    @section = params[:section]
    @completed = params[:completed]
  end

  def completed?
    @completed
  end

  def quiz_score
    correct_answers.size.fdiv(section.quizzes.last.answers.size)
  end

  def correct_answers
    section.quizzes.last.answers.correct
  end

  def position
    section.position
  end

  include Comparable
  def <=>(other)
    position <=> other.position
  end
end