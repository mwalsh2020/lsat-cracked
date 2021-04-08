class User::CourseStatus::NextInLine
  attr_reader :user, :course_status

  def initialize(params)
    @course_status = params[:course_status]
    @user = params[:user]
  end

  def next_from_top
    @course_status.missing_sections.order("chapters.position ASC, sections.position ASC").first
  end

  def last_section
    last_quiz.quizable
  end

  def last_quiz
    user.quizzes.reportable.where(quizable_type: "Section").order(updated_at: :desc).first
  end

  def next_from_last_section
    last_section.next
  end
end
