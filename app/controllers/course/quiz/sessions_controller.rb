class Course::Quiz::SessionsController < Course::ApplicationController
  def create
    @quiz = Quiz.find(params[:quiz_id])
    @quiz_session = Quiz::Session.new(quiz_session_params.merge(quiz: @quiz))

    authorize @quiz_session

    if @quiz_session.save
      redirect_to course_section_path(@quiz.quizable, anchor: "quiz")
    else
      @section = @quiz_session.quiz.quizable
      render "course/sections/show"
    end
  end

  private

  def quiz_session_params
    params.fetch(:quiz_session, {}).permit(quiz_questions_attributes: [:id, :answer_id])
  end
end
