class CoursesController < ApplicationController
  def show
    @chapters = Chapter.all
  end
end
