class Course::SectionsController < ApplicationController
  layout "course"

  def show
    @chapters = Chapter.all
    @section = Section.find(params[:id])
    authorize @section
  end
end
