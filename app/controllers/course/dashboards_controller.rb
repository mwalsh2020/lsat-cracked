class Course::DashboardsController < Course::ApplicationController
  def show
    authorize [:course, :dashboard]

    # TODO: make this not insane!
    @section = policy_scope(Chapter).first.sections.first

    redirect_to course_section_path(@section)
  end
end
