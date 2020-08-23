class Course::SectionsController < Course::ApplicationController
  def show
    @section = Section.find(params[:id])
    @quiz_session = build_or_find_quiz.session if @section.quiz?

    authorize @section
  end

  private

  def build_or_find_quiz
    quiz = policy_scope(Quiz).find_or_initialize_by(section: @section)
    quiz.update!(questions: @section.questions) unless quiz.persisted?
    quiz
  end
end
