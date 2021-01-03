class Admin::AnswersController < Admin::ApplicationController
  before_action :set_question, only: %i[new create]

  def new
    @answer = Answer.new
    authorize [:admin, @answer]
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.question = @question
    authorize [:admin, @answer]

    if @answer.save
      redirect_to admin_questions_path
    else
      render :new
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    authorize [:admin, @answer]
    @answer.destroy!

    redirect_to [:admin, :questions]
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  
  def answer_params
    params.require(:answer).permit(:content, :correct)
  end
end
