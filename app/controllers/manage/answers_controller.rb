class Manage::AnswersController < Manage::ApplicationController
  before_action :set_question, only: %i[new create]

  def new
    @answer = Answer.new
    authorize [:manage, @answer]
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.question = @question
    authorize [:manage, @answer]

    if @answer.save
      redirect_to manage_questions_path
    else
      render :new
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    authorize [:manage, @answer]
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
