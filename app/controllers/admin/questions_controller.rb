class Admin::QuestionsController < ApplicationController
  def new
    @section  = Section.find(params[:section_id])
    @question = Question.new
    authorize @question
  end

  def create
    @section  = Section.find(params[:section_id])
    @question = Question.new(question_params)
    @question.section = @section
    authorize @question

    if @question.save
      redirect_to admin_chapters_path
    else
      render :new
    end
  end

  def index
    @section  = Section.find(params[:section_id])
    @questions = policy_scope(@section.questions)
  end

  private

  def question_params
    params.require(:question).permit(:content)
  end
end
