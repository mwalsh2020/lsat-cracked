class Course::SectionsController < Course::ApplicationController
  def show
    @section = Section.find(params[:id])
    @quiz_session = build_or_find_quiz_session if @section.quiz?

    authorize @section
  end

  private

  def build_or_find_quiz_session
    # TODO: move user filtering to a policy scope
    quiz = policy_scope(Quiz).pending.find_or_initialize_by(section: @section)
    quiz.update!(questions: @section.questions) unless quiz.persisted?
    quiz.session
  end
end
