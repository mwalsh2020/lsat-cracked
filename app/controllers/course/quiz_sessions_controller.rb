class Course::QuizSessionsController < Course::ApplicationController
  def update
    @quiz_session = QuizSession.find(params[:id])
    authorize @quiz_session

    if @quiz_session.update(quiz_session_params.merge(complete: true))
      redirect_to course_section_path(@quiz_session.section, anchor: "quiz")
    else
      render "course/sections/show"
    end
  end

  private

  def quiz_session_params
    params.require(:quiz_session).permit(quiz_questions_attributes: [:id, :answer_id])
  end
end
