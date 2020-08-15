class Course::SectionsController < Course::ApplicationController
  def show
    @section = Section.find(params[:id])
    @quiz_session = build_or_find_quiz_session if @section.quiz?

    authorize @section
  end

  private

  def build_or_find_quiz_session
    # TODO: move user filtering to a policy scope
    quiz_session = policy_scope(QuizSession).pending.find_or_initialize_by(section: @section)
    quiz_session.update(questions: @section.questions) unless quiz_session.persisted?
    quiz_session
  end
end
