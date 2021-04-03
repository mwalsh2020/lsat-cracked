class Course::DashboardsController < Course::ApplicationController
  def show
    authorize [:course, :dashboard]

    @section = policy_scope(Chapter).first.sections.first
    @performance = QuizQuestion::PerformanceQuery.new(current_user.quiz_questions)
  end
end
