class Course::SectionsController < Course::ApplicationController
  def show
    @section = Section.find(params[:id])
    @quiz_session = get_quiz.session

    authorize @section
  end

  private

  def get_quiz
    quiz_builder = QuizBuilder.new(user: current_user, section: @section)
    quiz_builder.build_and_save
  end
end
