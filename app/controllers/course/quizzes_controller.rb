class Course::QuizzesController < Course::ApplicationController
  def update
    @quiz = Quiz.includes(:quiz_questions).find(params[:id])
    @section = @quiz.section
    authorize @quiz

    @quiz.complete = true
    if @quiz.update(quiz_params)
      redirect_to course_section_path(@section, anchor: "quiz")
    else
      render "course/sections/show"
    end
  end

  private

  def quiz_params
    params.require(:quiz).permit(quiz_questions_attributes: [:id, :answer_id])
  end
end
