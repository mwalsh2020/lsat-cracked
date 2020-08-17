class Course::DashboardsController < ApplicationController
  def show
    authorize [:course, :dashboard]
    @section = Section.first
    redirect_to course_section_path(@section)
  end
end
