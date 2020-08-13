class Course::SectionsController < ApplicationController
  def show
    @chapters = Chapter.all
    @section = Section.find(params[:id])
    authorize @section
  end
end
