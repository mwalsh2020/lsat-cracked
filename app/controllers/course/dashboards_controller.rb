class Course::DashboardsController < Course::ApplicationController
  def show
    authorize [:course, :dashboard]
    
    @section = policy_scope(Chapter).first.sections.first
  end
end
