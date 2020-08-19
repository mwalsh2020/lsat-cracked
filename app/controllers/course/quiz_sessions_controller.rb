class Course::QuizSessionsController < Course::ApplicationController
  def update
    @quiz_session = QuizSession.includes(:quiz_questions).find(params[:id])
    @section = @quiz_session.section
    authorize @quiz_session

    @quiz_session.complete = true
    if @quiz_session.update(quiz_session_params)
      redirect_to course_section_path(@section, anchor: "quiz")
    else
      render "course/sections/show"
    end
  end

  private

  def quiz_session_params
    params.require(:quiz_session).permit(quiz_questions_attributes: [:id, :answer_id])
  end
end
