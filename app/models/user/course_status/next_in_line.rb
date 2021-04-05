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
    user.quizzes.where(quizable_type: "Section").order(created_at: :desc).first.quizable
  end

  def next_from_last_section
    last_section.next
  end
end