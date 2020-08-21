class Course::SessionsController < Course::ApplicationController
  def create
    @quiz_session = Quiz.find(params[:quiz_id]).session

    authorize @quiz_session

    if @quiz_session.valid?
      redirect_to course_section_path(quiz.section, anchor: "quiz")
    else
      @section = @quiz_session.quiz.section
      render "course/sections/show"
    end
  end
end
