class Course::DashboardsController < Course::ApplicationController
  def show
    authorize [:course, :dashboard]

    # TODO: make this not insane!
    @section = policy_scope(Chapter).first.sections.first

  end
end
