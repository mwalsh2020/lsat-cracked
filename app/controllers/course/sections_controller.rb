class Course::SectionsController < ApplicationController
  layout "course"

  def show
    @chapters = Chapter.all
    @section = Section.find(params[:id])
    @quiz_session = build_or_find_quiz_session

    authorize @section
  end

  private

  def build_or_find_quiz_session
    quiz_session = QuizSession.find_or_initialize_by(user: current_user, section: @section)

    if quiz_session.persisted?
      quiz_session
    else
      # Build it with all questions from the section
    end
  end
end
