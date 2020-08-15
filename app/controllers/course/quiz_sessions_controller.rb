class Course::QuizSessionsController < Course::ApplicationController
  def update
    @quiz_session = QuizSession.find(params[:id])
    authorize @quiz_session

    if @quiz_session.update(quiz_session_params.merge(complete: true))
      redirect_to report_course_quiz_session_path(@quiz_session)
    else
      render "course/sections/show"
    end
  end

  def report
    @quiz_session = QuizSession.find(params[:id])
    authorize @quiz_session
  end

  private

  def quiz_session_params
    params.require(:quiz_session).permit(quiz_questions_attributes: [:id, :answer_id])
  end
end
