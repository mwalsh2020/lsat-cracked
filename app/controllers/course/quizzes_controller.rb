class Course::QuizzesController < ApplicationController
  def create
    @section = Section.find(params[:section_id])
    @quiz = QuizBuilder.new(user: current_user, section: @section).new_quiz
    @quiz.save!

    authorize @quiz

    redirect_to course_section_path(@section, anchor: "quiz")
  end
end
