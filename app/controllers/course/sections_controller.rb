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
    # TODO: move user filtering to a policy scope
    quiz_session = QuizSession.pending.find_or_initialize_by(user: current_user, section: @section)
    quiz_session.update(questions: @section.questions) unless quiz_session.persisted?
    quiz_session
  end
end
