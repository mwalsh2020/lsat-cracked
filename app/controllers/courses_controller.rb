class CoursesController < ApplicationController
  def show
    authorize :course
    @chapters = Chapter.all
  end
end
